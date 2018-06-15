//
//  ViewController.swift
//  damier
//
//  Created by Benoit NEUTS on 01/06/2018.
//  Copyright © 2018 Benoit NEUTS. All rights reserved.
//

import UIKit


class ViewController : UIViewController {
    
    @IBOutlet weak var boardAsCollectionView: UICollectionView!
    let appDlg = UIApplication.shared.delegate as! AppDelegate

    var imageView : UIImageView?
    
    var startPointX : CGFloat = -1.0
    var startPointY : CGFloat = -1.0
    
    var pannedZone : PawnBoxInfo?
    
    var cellAtFirstTouched : UICollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardAsCollectionView.dataSource = self
        
        //let panGR = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanGesture(_:)))
        //panGR.delegate = self
        //BoardAsCollectionView.addGestureRecognizer(panGR)
    }
    
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // TODO : créer un Model static et instancier et mettre à disposition board dedans
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! PawnBoxCell
        
        cell.configure(withCase: appDlg.board.getPawnInfo(x: indexPath.row, y: indexPath.section))
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 10
        return CGSize(width: width, height: width)
    }
}


extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Manage an invalid drag (no pion on this case / not current pion to be played)
        return true
    }
    
    @IBAction func handlePanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let locationPoint = panGestureRecognizer.location(in: boardAsCollectionView)
        if (startPointX<0)
        {
            startPointX = locationPoint.x
        }
        if (startPointY<0)
        {
            startPointY = locationPoint.y
        }
        if panGestureRecognizer.state == .began {
            // Create a current viewCell "screenshot" / TODO: only pionView should be duplicated
            let indexPathOfMovingCell = boardAsCollectionView.indexPathForItem(at: locationPoint)!
            
            cellAtFirstTouched = boardAsCollectionView.cellForItem(at: indexPathOfMovingCell)
            UIGraphicsBeginImageContext((cellAtFirstTouched?.bounds.size)!)
            
            pannedZone = appDlg.board.getPawnInfo(x: boardAsCollectionView.indexPath(for: cellAtFirstTouched!)!.row, y: boardAsCollectionView.indexPath(for: cellAtFirstTouched!)!.section)

            if (pannedZone?.pion) != nil {
                let ctx = UIGraphicsGetCurrentContext()!
                cellAtFirstTouched?.layer.render(in: ctx)
                
                let cellImage = UIGraphicsGetImageFromCurrentImageContext()
                imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: (cellAtFirstTouched?.bounds.width)!, height:
                    (cellAtFirstTouched?.bounds.height)!))
                if let imageView = imageView {
                    imageView.transform = imageView.transform.scaledBy(x: 1.5,y: 1.5)
                    imageView.image = cellImage
                    boardAsCollectionView.addSubview(imageView)
                    imageView.center = locationPoint
                    imageView.layer.cornerRadius = imageView.frame.size.width / (1.5 * 2)
                    imageView.clipsToBounds = true

                }
                // TODO: make moving view bigger (as it is upper from other "
                // use UIView transform property and CGAffineTransform(scaleX:y:) to achieve this
                // TODO: reconfigure current cell to be in state "moving away" (pion can have a alpha of 0.5 to

            }
            
        }
        if panGestureRecognizer.state == .changed {
            print("pan at \(locationPoint)")
            imageView?.center = locationPoint
        }
        if panGestureRecognizer.state == .ended {
            // TODO: manage if movement is valid (update model accordingly)

            let imgView = imageView
            let startPtX = self.startPointX
            self.startPointX = -1
            let startPtY = self.startPointY
            self.startPointY = -1
            
            let currentPawn = pannedZone
            pannedZone = nil
            
            let indexPathOfLastTouchedCell = boardAsCollectionView.indexPathForItem(at: locationPoint)!
            
            let lastTouchedCell = boardAsCollectionView.cellForItem(at: indexPathOfLastTouchedCell)!

            let lastTouchedCase = appDlg.board.getPawnInfo(x: boardAsCollectionView.indexPath(for: lastTouchedCell)!.row, y: boardAsCollectionView.indexPath(for: lastTouchedCell)!.section)

            if let cpwn = currentPawn
            {
                if cpwn.canMoveTo(lastTouchedCell: lastTouchedCell)
                    {
                        //TODO : boardAsCollectionView.reloadItems(at: <#T##[IndexPath]#>)
                        //view.reDraw(lastTouchedCell,cellAtFirstTouched)
                    }
            }
            
            UIView.animate(
                withDuration: 0.5,
                animations: {
                    imgView?.center = CGPoint(x: startPtX, y: startPtY)
                    imgView?.alpha = 1.0
                },
                completion: {
                    _ in
                    imgView?.removeFromSuperview()
                }
            )
            
        }
    } }
