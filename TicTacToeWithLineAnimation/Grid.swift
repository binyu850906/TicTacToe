//
//  Grid.swift
//  TicTacToeWithLineAnimation
//
//  Created by binyu on 2021/7/31.
//

import Foundation

class Grid {
    enum Piece {
        case O
        case X
    }
    
    let squareCount = 9
    lazy var squares = [Piece?](repeating: nil, count: squareCount)
    
    let lines = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    var isFull: Bool {
        return squares.indices.allSatisfy { (index) -> Bool in
            return isSquareEmpty(index: index) == false
        }
    }
    
    var isTie: Bool {
        if isFull, winner == nil {
            return true
        }else {
            return false
        }
    }
    
    func isSquareEmpty(index: Int) -> Bool {
        return squares[index] == nil
    }
    
    func occupy(piece: Piece, on index: Int) {
        squares[index] = piece
    }
    
    func clear() {
        squares = [Piece?](repeating: nil, count: squareCount)
    }
    
    var winner: Piece? {
        var winner: Piece?
        for line in lines {
            if let firstPiece = squares[line[0]]{
                print(firstPiece)
                let result = line.allSatisfy { index -> Bool in
                    return squares[index] == firstPiece
                }
                if result {
                    winner = firstPiece
                    break
                }
            }
        }
            
        return winner
    }
    
    
    var winnerLines: [[Int]] {
        var winnerLines = [[Int]]()
        for line in lines {
            if let firstPiece = squares[line[0]] {
                let result = line.allSatisfy { index -> Bool in
                    squares[index] == firstPiece
                }
                
                if result {
                    winnerLines.append(line)
                }
            }
        }
        return winnerLines
    }
}
