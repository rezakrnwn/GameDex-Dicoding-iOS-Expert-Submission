//
//  Resolver+Injection.swift
//  GameDex
//
//  Created by Reza Kurniawan on 29/03/25.
//

import Foundation
import RealmSwift
import GameDexCore
import Favorite
import Game
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        // ViewModel
        register { HomeViewModel(fetchGamesUseCase: resolve()) }
        register { DetailViewModel(
            fetchGameDetailUseCase: resolve(),
            getFavoriteByIdUseCase: resolve(),
            addFavoriteUseCase: resolve(),
            deleteFavoriteUseCase: resolve()
        ) }
        register { FavoriteViewModel(getFavoritesUseCase: resolve()) }
    }
}
