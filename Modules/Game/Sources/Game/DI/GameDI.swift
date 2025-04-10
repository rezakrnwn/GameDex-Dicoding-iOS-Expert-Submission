//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 10/04/25.
//

import Foundation
import Resolver

public extension Resolver {
    static func registerGameDependencies() {
        // Data Source
        register { GameRemoteDataSource(networkClient: resolve()) as GameRemoteDataSourceProtocol }
        
        // Repository
        register { GameRepository(gameRemoteDataSource: resolve()) as GameRepositoryProtocol }
        
        // UseCase
        register { FetchGamesUseCase(gameRepository: resolve()) }
        register { FetchGameDetailUseCase(gameRepository: resolve()) }
    }
}
