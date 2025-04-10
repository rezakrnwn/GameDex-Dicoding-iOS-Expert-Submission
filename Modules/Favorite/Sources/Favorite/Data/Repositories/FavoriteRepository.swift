//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import Combine

class FavoriteRepository: FavoriteRepositoryProtocol {
    private let favoriteLocalDataSource: FavoriteLocalDataSourceProtocol
    
    init(favoriteLocalDataSource: FavoriteLocalDataSourceProtocol) {
        self.favoriteLocalDataSource = favoriteLocalDataSource
    }
    
    func getFavorites() -> AnyPublisher<[GameFavorite], Error> {
        return favoriteLocalDataSource.getFavorites().map { locals in
            locals.map { local in
                local.toFavoriteDomain()
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoriteById(id: Int) -> AnyPublisher<GameFavorite?, Error> {
        return favoriteLocalDataSource.getFavoriteById(id: id).map { local in
            local?.toFavoriteDomain()
        }.eraseToAnyPublisher()
    }
    
    func addFavorite(gameFavorite: GameFavorite) -> AnyPublisher<Bool, Error> {
        let entity = GameFavoriteEntity()
        entity.id = gameFavorite.id
        entity.name = gameFavorite.name
        entity.release = gameFavorite.release
        entity.rating = gameFavorite.rating
        entity.backgroundImage = gameFavorite.backgroundImage.absoluteString
        return favoriteLocalDataSource.addFavorite(favorite: entity)
            .eraseToAnyPublisher()

    }
    
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return favoriteLocalDataSource.deleteFavorite(id: id)
            .eraseToAnyPublisher()
    }
}
