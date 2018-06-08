//
//  PawnBoxCell.swift
//  damier
//
//  Created by Benoit NEUTS on 01/06/2018.
//  Copyright © 2018 Benoit NEUTS. All rights reserved.
//

import UIKit

class PawnBoxCell : UICollectionViewCell {

    @IBOutlet weak var pionView: UIView!
    @IBOutlet weak var caseBackgroundImageView: UIImageView!

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pionView.isHidden = false
    }
    
    
    func configure(withCase casePion: PawnBoxInfo?) {
        if let casePion = casePion {
            pionView.backgroundColor = casePion.isBlack ? UIColor.black : UIColor.white
            pionView.layer.cornerRadius = 0
            caseBackgroundImageView.alpha = 0.5

            if let pion = casePion.pion {
                pionView.layer.cornerRadius = frame.size.width / 2.0
                if  pion.isWhite {
                    pionView.backgroundColor = UIColor.white
                } else {
                    pionView.backgroundColor = UIColor.black
                }
            }
        }
    }
    
    
    
}
