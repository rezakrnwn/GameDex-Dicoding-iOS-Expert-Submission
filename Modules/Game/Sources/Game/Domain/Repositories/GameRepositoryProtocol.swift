//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
    func getGames() -> AnyPublisher<[Game], Error>
    func getGameDetail(_ id: Int) -> AnyPublisher<GameDetail, Error>
}
