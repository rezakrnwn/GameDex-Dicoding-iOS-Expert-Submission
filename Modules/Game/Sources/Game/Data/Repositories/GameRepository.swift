//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import Foundation
import Combine

public class GameRepository: GameRepositoryProtocol {
    private let gameRemoteDataSource: GameRemoteDataSourceProtocol
    
    init(gameRemoteDataSource: GameRemoteDataSourceProtocol) {
        self.gameRemoteDataSource = gameRemoteDataSource
    }
    
    func getGames() -> AnyPublisher<[Game], Error> {
        return gameRemoteDataSource.getGames().map { response in
            response.results.map { game in
                game.toGameEntity()
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameDetail(_ id: Int) -> AnyPublisher<GameDetail, Error> {
        return gameRemoteDataSource.getGameDetail(id).map { response in
            response.toGameDetailEntity()
        }.eraseToAnyPublisher()
    }
}
