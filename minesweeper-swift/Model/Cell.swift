//
//  Cell.swift
//  minesweeper-swift
//
//  Created by 三宅　武将 on 2023/08/10.
//

import SwiftUI

struct Cell {
    var isMine = false
    var isRevealed = false
    var isFlagged = false
    var neighboringMines = 0
}
