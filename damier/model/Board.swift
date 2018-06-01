//
//  Board.swift
//  damier
//
//  Created by Benoit NEUTS on 25/05/2018.
//  Copyright © 2018 Benoit NEUTS. All rights reserved.
//

import Foundation

public class Board {
    
    var cells = [PawnBoxInfo]()
    
    init() {
        var isBlack = false
        for x in 1...10 {
            for y in 1...10 {
                cells.append(PawnBoxInfo(cell: PawnBoxCell(), x: x,y: y,isBlack: isBlack, pion: nil))
                isBlack = !isBlack
            }
        }
    }
    
    
    func getPawnInfo(x : Int, y : Int) -> PawnBoxInfo? {
        for pawn in cells {
            if ((pawn.x == x) && (pawn.y == y)) {
                return pawn
            }
        }
        return nil
    }
}
