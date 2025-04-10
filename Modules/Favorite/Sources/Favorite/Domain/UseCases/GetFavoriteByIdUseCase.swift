//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import Combine
import GameDexCore

public class GetFavoriteByIdUseCase: BaseUseCase {
    public typealias Request = Int
    public typealias Response = GameFavorite?
    private let favoriteRepository: FavoriteRepositoryProtocol
    
    init(favoriteRepository: FavoriteRepositoryProtocol) {
        self.favoriteRepository = favoriteRepository
    }
    
    public func execute(_ request: Int) -> AnyPublisher<GameFavorite?, Error> {
        return favoriteRepository.getFavoriteById(id: request)
            .eraseToAnyPublisher()
    }
}
