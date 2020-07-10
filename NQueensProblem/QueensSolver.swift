//
//  QueensSolver.swift
//  SwiftAGDS
//
//  Created by Derrick Park on 2019-03-13.
//  Code from iamjason github eight-queens, adapted by Leandro Prado
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

/// Write a function solveQueens that accepts a Board as a parameter
/// and tries to place 8 queens on it safely.
///
/// - Your method should stop exploring if it finds a solution
/// - You are allowed to change the function header (args or return type)
/// - Your total recursive calls should not exceed 120 times.
//func solveQueens(board: inout Board) {
//    count += 1
//}

//global variables:
//var count = 0
var solutionsFound = 0
var positionsChecked = 0
let printSolutions = true
let boardWidth = 7

//class to initialize the queens in each row:
class Queen {
    var column:Int
    var row:Int
    
    init(forRow:Int){
        row  = forRow
        column = 0
    }
} //end class

//create 8 queen objects, initialized to rows 0 - 7
let queens:[Queen] = (0...boardWidth).map{ Queen(forRow: $0) }


func isSafe(currentRow:Int, currentColumn:Int) -> Bool {
    positionsChecked += 1
    
    for previousRow in 0 ..< currentRow {
        
        // check vertical
        if queens[previousRow].column == currentColumn {
            return false
        }
        
        // check diagonal
        let dRow = currentRow - previousRow
        let dCol = currentColumn - queens[previousRow].column
        if dRow == dCol || dRow == -dCol {
            return false
        }
        
    }
    
    // if no other queen is found above, it's a safe spot on the board
    queens[currentRow].column = currentColumn
    return true
    
} //end func isSafe


func moveQueenAcrossRow(row:Int) {
    
    for column in 0...boardWidth {
    
        // Move queen column by column, checking if it's in a safe place
        if isSafe(currentRow: row, currentColumn: column) {
            
            // if we've found the 8th queen, that's an ANSWER!
            if row == boardWidth {
                solutionsFound += 1
                if printSolutions {
                 printBoard()
                }
            } else {
                
                // recursive call to move the queen to the next row
                moveQueenAcrossRow(row: row + 1)
            }
        }
    } //end for column in 0...boardWidth
    
} //end func moveQueenAcrossRow

func printBoard() {
    
    print("Solution #: \(solutionsFound)\n")
    
    // top down
    for currentRow in Array(0...boardWidth) {
        print("\(currentRow + 1)", terminator: "")
        // left to right
        for currentColumn in 0...boardWidth {
            if queens[currentRow].column == currentColumn {
                print(" Q ", terminator: "")
            } else {
                print(" - ", terminator: "")
            }
        } //end for currentColumn
        print("")
    } //end for currentRow
    
    print("  A  B  C  D  E  F  G  H \n\n")
    
} //end func printBoard
