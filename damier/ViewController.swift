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
        let appDlg = UIApplication.shared.delegate as! AppDelegate
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! PawnBoxCell
        
        cell.configure(withCase: appDlg.board.getPawnInfo(x: indexPath.row, y: indexPath.section))
        
        return cell
    }
    
}
