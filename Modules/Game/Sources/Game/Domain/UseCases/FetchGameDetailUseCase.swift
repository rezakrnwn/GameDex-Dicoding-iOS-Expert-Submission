//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import Foundation
import Combine
import GameDexCore

public class FetchGameDetailUseCase: BaseUseCase {
    public typealias Request = Int
    public typealias Response = GameDetail
    private let gameRepository: GameRepositoryProtocol
    
    init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    public func execute(_ request: Int) -> AnyPublisher<GameDetail, Error> {
        return gameRepository.getGameDetail(request)
            .eraseToAnyPublisher()
    }
}
