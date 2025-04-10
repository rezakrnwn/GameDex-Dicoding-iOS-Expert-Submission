//
//  GameDexApp.swift
//  GameDex
//
//  Created by Reza Kurniawan on 29/03/25.
//

import SwiftUI
import Resolver
import GameDexCore
import Game
import Favorite

@main
struct GameDexApp: App {
    init() {
        Resolver.registerCoreDependencies()
        Resolver.registerGameDependencies()
        Resolver.registerFavoriteDependencies()
        Resolver.registerAllServices()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
