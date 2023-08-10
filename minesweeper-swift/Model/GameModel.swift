//
//  GameModel.swift
//  minesweeper-swift
//
//  Created by 三宅　武将 on 2023/08/10.
//

import SwiftUI

class GameModel: ObservableObject {
    static let rows = 8
    static let cols = 8
    static let mines = 10
    
    @Published var cells: [[Cell]] = Array(repeating: Array(repeating: Cell(), count: rows), count: cols)
    @Published var isGameOver = false
    @Published var firstTapPosition: (Int, Int)? = nil
    
    func startGame(withFirstPosition position: (Int, Int)) {
        firstTapPosition = position
        
        placeMines(excluding: position)
        
        isGameOver = false
        
        openCell(row: position.0, col: position.1)
    }
    
    private func placeMines(excluding position: (Int, Int)) {
        var minePositions: [(Int, Int)] = []
        
        // ランダムに爆弾を配置
        while minePositions.count < GameModel.mines {
            let row = Int.random(in: 0..<GameModel.rows)
            let col = Int.random(in: 0..<GameModel.cols)
            let pos = (row, col)
            
            if pos != position && !minePositions.contains(where: {$0 == pos}) {
                minePositions.append(pos)
                cells[row][col].isMine = true
            }
        }
        
        for row in 0..<GameModel.rows {
            for col in 0..<GameModel.cols {
                cells[row][col].neighboringMines = neighboringMinesCount(row: row, col: col)
            }
        }
    }
    
    func neighboringMinesCount(row: Int, col: Int) -> Int{
        let neighbors = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1), (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]
        
        var count = 0
        
        for (dx, dy) in neighbors {
            let newRow = row + dx
            let newCol = col + dy
            
            if newRow >= 0 && newRow < GameModel.rows && newCol >= 0 && newCol < GameModel.cols && cells[newRow][newCol].isMine {
                count += 1
            }
        }
        
        return count
    }
    
    func openCell(row: Int, col: Int) {
        // 画面外をタップ
        if row < 0 || row >= GameModel.rows || col < 0 || col >= GameModel.cols {
            return
        }
        
        // 既に開いているセルをタップ
        if cells[row][col].isRevealed {
            return
        }
        
        // flagが立っているセルをタップ
        if cells[row][col].isFlagged {
            return
        }
        
        cells[row][col].isRevealed = true
        
        if cells[row][col].neighboringMines == 0 {
            let neighbors = [
                (-1, -1), (-1, 0), (-1, 1),
                (0, -1), (0, 1),
                (1, -1), (1, 0), (1, 1)
            ]
            
            for (dx, dy) in neighbors {
                openCell(row: row + dx, col: col + dy)
            }
        }
    }
    
    func toggleFlag(row: Int, col: Int) {
        if cells[row][col].isRevealed { return }
        cells[row][col].isFlagged.toggle()
        print(cells[row][col])
    }
    
    func resetGame() {
        cells = Array(repeating: Array(repeating: Cell(), count: GameModel.rows), count: GameModel.cols)
        isGameOver = false
        firstTapPosition = nil
    }
}
