//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import Foundation
import Combine
import GameDexCore

protocol GameRemoteDataSourceProtocol {
    func getGames() -> AnyPublisher<GamesResponse, Error>
    func getGameDetail(_ id: Int) -> AnyPublisher<GameDetailResponse, Error>
}

class GameRemoteDataSource: GameRemoteDataSourceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getGames() -> AnyPublisher<GamesResponse, Error> {
        return networkClient.request(APIEndpoints.games(), responseType: GamesResponse.self)
            .eraseToAnyPublisher()
    }
    
    func getGameDetail(_ id: Int) -> AnyPublisher<GameDetailResponse, Error> {
        return networkClient.request(APIEndpoints.gameDetail(id: id), responseType: GameDetailResponse.self)
            .eraseToAnyPublisher()
    }
}
