//
//  ContentView.swift
//  minesweeper-swift
//
//  Created by 三宅　武将 on 2023/08/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game: GameModel
    var body: some View {
        VStack {
            ForEach(0..<GameModel.rows, id: \.self) { row in
                HStack {
                    ForEach(0..<GameModel.cols, id: \.self) {col in
                        CellView(row: row, col: col)
                            .onTapGesture {
                                if game.firstTapPosition == nil {
                                    game.startGame(withFirstPosition: (row, col))
                                } else {
                                    game.openCell(row: row, col: col)
                                }
                            }
                            .onLongPressGesture {
                                game.toggleFlag(row: row, col: col)
                            }
                    }
                }
            }
            Button("Restart") {
                game.resetGame()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GameModel())
    }
}
