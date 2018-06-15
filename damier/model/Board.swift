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
    
    var isToTopForBlack : Bool = false
    
    init() {
        var isBlack = false
        for x in 0...9 {
            isBlack = !isBlack
            for y in 0...9 {
                var pion : Pawn?
                if ( y < 4 )
                {
                    if ( ( x % 2 > 0 && ((y+1) % 2 > 0)) || ( (x+1) % 2 > 0 && (y % 2 > 0))) {
                        pion = Pawn()
                    }
                }
                if (y > 5 )
                {
                    if ( ( x % 2 > 0 && ((y+1) % 2 > 0)) || ( (x+1) % 2 > 0 && (y % 2 > 0))) {
                        pion = Pawn()
                        pion!.isWhite = true
                    }
                }
                cells.append(PawnBoxInfo(cell: PawnBoxCell(), x: x,y: y,isBlack: isBlack, pion: pion!))
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
