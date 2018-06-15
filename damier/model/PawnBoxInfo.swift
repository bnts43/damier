//
//  PawnBoxInfo.swift
//  damier
//
//  Created by Benoit NEUTS on 01/06/2018.
//  Copyright © 2018 Benoit NEUTS. All rights reserved.
//

import UIKit

class PawnBoxInfo {
    var cell : PawnBoxCell?
    var x:Int = -1
    var y:Int = -1
    var isBlack=false
    var pion : Pawn?

    init(cell: PawnBoxCell, x: Int,y: Int,isBlack: Bool, pion: Pawn) {
        self.cell = cell
        self.x = x
        self.y = y
        self.isBlack = isBlack
        self.pion = pion
    }
    
    func canMoveTo(lastTouchedCell: UICollectionViewCell?) -> Bool {
        return false
    }

}

