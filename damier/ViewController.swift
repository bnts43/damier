//
//  ViewController.swift
//  damier
//
//  Created by Benoit NEUTS on 01/06/2018.
//  Copyright © 2018 Benoit NEUTS. All rights reserved.
//

import UIKit


class ViewController : UIViewController {
    
    @IBOutlet weak var BoardAsCollectionView: UICollectionView!
    let appDlg = UIApplication.shared.delegate as! AppDelegate

    var imageView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BoardAsCollectionView.dataSource = self
        
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
        let locationPoint = panGestureRecognizer.location(in: BoardAsCollectionView)
        if panGestureRecognizer.state == .began {
            // Create a current viewCell "screenshot" / TODO: only pionView should be duplicated
            let indexPathOfMovingCell = BoardAsCollectionView.indexPathForItem(at: locationPoint)!
            let cell = BoardAsCollectionView.cellForItem(at: indexPathOfMovingCell)!
            UIGraphicsBeginImageContext(cell.bounds.size)
            if let pion = appDlg.board.getPawnInfo(x: BoardAsCollectionView.indexPath(for: cell)!.row, y: BoardAsCollectionView.indexPath(for: cell)!.section)?.pion {
                
                let ctx = UIGraphicsGetCurrentContext()!
                cell.layer.render(in: ctx)
                let cellImage = UIGraphicsGetImageFromCurrentImageContext()
                imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height:
                    cell.bounds.height))
                if let imageView = imageView {
                    imageView.transform = imageView.transform.scaledBy(x: 2,y: 2)
                    imageView.image = cellImage
                    BoardAsCollectionView.addSubview(imageView)
                    imageView.center = locationPoint
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
            imageView?.removeFromSuperview()
        }
    } }
