//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import Foundation
import Combine
import GameDexCore

public class FetchGamesUseCase: BaseUseCase {
    public typealias Request = Void
    public typealias Response = [Game]
    private let gameRepository: GameRepositoryProtocol
    
    init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    public func execute(_ request: Void) -> AnyPublisher<[Game], Error> {
        return gameRepository.getGames()
            .eraseToAnyPublisher()
    }
}
