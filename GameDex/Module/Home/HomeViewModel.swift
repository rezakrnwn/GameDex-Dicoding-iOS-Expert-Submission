//
//  HomeViewModel.swift
//  GameDex
//
//  Created by Reza Kurniawan on 29/03/25.
//

import Foundation
import Combine
import Resolver
import Game

class HomeViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let fetchGamesUseCase: FetchGamesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchGamesUseCase: FetchGamesUseCase) {
        self.fetchGamesUseCase = fetchGamesUseCase
    }
    
    func fetchGames() {
        isLoading = true
        errorMessage = nil
        
        fetchGamesUseCase.execute(())
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        self.errorMessage = String(describing: completion)
                        self.isLoading = false
                    case .finished:
                        self.isLoading = false
                    }
                }, receiveValue: { games in
                    self.games = games
                })
            .store(in: &cancellables)
    }
}
