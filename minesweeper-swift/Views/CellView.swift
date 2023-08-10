//
//  CellView.swift
//  minesweeper-swift
//
//  Created by 三宅　武将 on 2023/08/10.
//

import SwiftUI

struct CellView: View {
    @EnvironmentObject var game: GameModel
    var row: Int
    var col: Int
    
    var body: some View {
        let cell = game.cells[row][col]
        return ZStack {
            if cell.isRevealed {
                if cell.isMine {
                    Image(systemName: "xmark.circle")
                } else {
                    Text(cell.neighboringMines > 0 ? "\(cell.neighboringMines)" : "")
                }
            } else {
                if cell.isFlagged {
                    Image(systemName: "flag")
                }
                Rectangle()
                    .fill(Color.gray)
            }
        }
        .frame(width: 30, height: 30)
        .overlay(
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(row: 8, col: 8).environmentObject(GameModel())
    }
}
