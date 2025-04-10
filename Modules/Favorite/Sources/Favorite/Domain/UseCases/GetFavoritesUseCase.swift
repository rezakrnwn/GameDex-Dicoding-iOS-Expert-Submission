//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import Combine
import GameDexCore

public class GetFavoritesUseCase: BaseUseCase {
    public typealias Request = Void
    public typealias Response = [GameFavorite]
    private let favoriteRepository: FavoriteRepositoryProtocol
    
    init(favoriteRepository: FavoriteRepositoryProtocol) {
        self.favoriteRepository = favoriteRepository
    }

    public func execute(_ request: Void) -> AnyPublisher<[GameFavorite], Error> {
        return favoriteRepository.getFavorites()
            .eraseToAnyPublisher()
    }
}
