//
//  minesweeper_swiftApp.swift
//  minesweeper-swift
//
//  Created by 三宅　武将 on 2023/08/10.
//

import SwiftUI

@main
struct minesweeper_swiftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GameModel())
        }
    }
}
