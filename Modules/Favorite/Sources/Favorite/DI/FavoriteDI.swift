//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import Foundation
import Resolver

public extension Resolver {
    static func registerFavoriteDependencies() {
        // Data Source
        register { FavoriteLocalDataSource(db: resolve()) as FavoriteLocalDataSourceProtocol }
        
        // Repository
        register { FavoriteRepository(favoriteLocalDataSource: resolve()) as FavoriteRepositoryProtocol }
        
        // UseCase
        register { GetFavoritesUseCase(favoriteRepository: resolve()) }
        register { GetFavoriteByIdUseCase(favoriteRepository: resolve()) }
        register { AddFavoriteUseCase(favoriteRepository: resolve()) }
        register { DeleteFavoriteUseCase(favoriteRepository: resolve()) }
    }
}
