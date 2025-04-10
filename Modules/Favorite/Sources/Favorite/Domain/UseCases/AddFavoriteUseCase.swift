//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import Combine
import GameDexCore

public class AddFavoriteUseCase: BaseUseCase {
    public typealias Request = GameFavorite
    public typealias Response = Bool
    private let favoriteRepository: FavoriteRepositoryProtocol
    
    init(favoriteRepository: FavoriteRepositoryProtocol) {
        self.favoriteRepository = favoriteRepository
    }
    
    public func execute(_ request: GameFavorite) -> AnyPublisher<Bool, Error> {
        return favoriteRepository.addFavorite(gameFavorite: request)
            .eraseToAnyPublisher()
    }
}
