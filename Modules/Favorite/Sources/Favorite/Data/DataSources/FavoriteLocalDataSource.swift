//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import Combine
import GameDexCore

protocol FavoriteLocalDataSourceProtocol {
    func addFavorite(favorite: GameFavoriteEntity) -> AnyPublisher<Bool, Error>
    
    func getFavorites() -> AnyPublisher<[GameFavoriteEntity], Error>
    
    func getFavoriteById(id: Int) -> AnyPublisher<GameFavoriteEntity?, Error>
    
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

class FavoriteLocalDataSource: FavoriteLocalDataSourceProtocol {
    private let db: LocalDatabase
    
    init(db: LocalDatabase) {
        self.db = db
    }
    
    func addFavorite(favorite: GameFavoriteEntity) -> AnyPublisher<Bool, Error> {
        return db.save(favorite)
            .eraseToAnyPublisher()
    }
    
    func getFavorites() -> AnyPublisher<[GameFavoriteEntity], Error> {
        return db.fetchAll(of: GameFavoriteEntity.self)
            .eraseToAnyPublisher()
    }
    
    func getFavoriteById(id: Int) -> AnyPublisher<GameFavoriteEntity?, Error> {
        return db.find(type: GameFavoriteEntity.self, forPrimaryKey: id)
            .eraseToAnyPublisher()
    }
    
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return db.deleteBy(GameFavoriteEntity.self, predicate: NSPredicate(format: "id = %d", id))
            .eraseToAnyPublisher()
    }
}
