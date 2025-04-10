//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import Combine
import GameDexCore

public class DeleteFavoriteUseCase: BaseUseCase {
    public typealias Request = Int
    public typealias Response = Bool
    private let favoriteRepository: FavoriteRepositoryProtocol
    
    init(favoriteRepository: FavoriteRepositoryProtocol) {
        self.favoriteRepository = favoriteRepository
    }
    
    public func execute(_ request: Int) -> AnyPublisher<Bool, Error> {
        return favoriteRepository.deleteFavorite(id: request)
            .eraseToAnyPublisher()
    }
}

