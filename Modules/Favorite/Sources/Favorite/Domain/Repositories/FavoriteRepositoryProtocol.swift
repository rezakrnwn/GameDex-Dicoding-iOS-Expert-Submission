//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import Combine

protocol FavoriteRepositoryProtocol {
    func getFavorites() -> AnyPublisher<[GameFavorite], Error>
    
    func getFavoriteById(id: Int) -> AnyPublisher<GameFavorite?, Error>
    
    func addFavorite(gameFavorite: GameFavorite) -> AnyPublisher<Bool, Error>
    
    func deleteFavorite(id: Int) -> AnyPublisher<Bool, Error>
}
