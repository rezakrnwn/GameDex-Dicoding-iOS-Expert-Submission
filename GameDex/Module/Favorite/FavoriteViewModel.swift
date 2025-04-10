//
//  FavoriteViewModel.swift
//  GameDex
//
//  Created by Reza Kurniawan on 30/03/25.
//

import Foundation
import Combine
import Resolver
import Favorite

class FavoriteViewModel: ObservableObject {
    @Published var favorites: [GameFavorite] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let getFavoritesUseCase: GetFavoritesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(getFavoritesUseCase: GetFavoritesUseCase) {
        self.getFavoritesUseCase = getFavoritesUseCase
    }
    
    func getFavorites() {
        isLoading = true
        errorMessage = nil
        
        getFavoritesUseCase.execute(())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { favorites in
                self.favorites = favorites
            })
            .store(in: &cancellables)
    }
}
