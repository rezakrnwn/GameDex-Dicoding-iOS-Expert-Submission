//
//  DetailViewModel.swift
//  GameDex
//
//  Created by Reza Kurniawan on 29/03/25.
//

import Foundation
import Combine
import Resolver
import Game
import Favorite

class DetailViewModel: ObservableObject {
    @Published var gameDetail: GameDetail?
    @Published var isLoading = false
    @Published var isFavorite = false
    @Published var errorMessage: String?
    @Published var description: AttributedString?
    
    private let fetchGameDetailUseCase: FetchGameDetailUseCase
    private let getFavoriteByIdUseCase: GetFavoriteByIdUseCase
    private let addFavoriteUseCase: AddFavoriteUseCase
    private let deleteFavoriteUseCase: DeleteFavoriteUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        fetchGameDetailUseCase: FetchGameDetailUseCase,
        getFavoriteByIdUseCase: GetFavoriteByIdUseCase,
        addFavoriteUseCase: AddFavoriteUseCase,
        deleteFavoriteUseCase: DeleteFavoriteUseCase
    ) {
        self.fetchGameDetailUseCase = fetchGameDetailUseCase
        self.getFavoriteByIdUseCase = getFavoriteByIdUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
    }
    
    func fetchGameDetail(_ id: Int) {
        isLoading = true
        errorMessage = nil

        Publishers.Zip(
               fetchGameDetailUseCase.execute(id),
               getFavoriteByIdUseCase.execute(id)
        )
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
                self.isLoading = false
            case .finished:
                self.isLoading = false
            }
        }, receiveValue: { [self] gameDetail, favoriteResult in
            self.gameDetail = gameDetail
            self.description = htmlToAttributedString(gameDetail.description)
            self.description?.font = .body
            self.isFavorite = favoriteResult != nil
        })
        .store(in: &cancellables)
    }
    
    func addFavorite(_ id: Int) {
        guard let gameDetail = self.gameDetail else {
            return
        }
        
        addFavoriteUseCase.execute(GameFavorite(
            id: id, name: gameDetail.name, release: gameDetail.release, rating: gameDetail.rating, backgroundImage: gameDetail.backgroundImage
        ))
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
                self.isLoading = false
            case .finished:
                self.isLoading = false
            }
        }, receiveValue: { result in
            self.isFavorite = result
        }).store(in: &cancellables)
    }
    
    func removeFavorite(_ id: Int) {
        guard self.gameDetail != nil else {
            return
        }
        
        deleteFavoriteUseCase.execute(id)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
                self.isLoading = false
            case .finished:
                self.isLoading = false
            }
        }, receiveValue: { result in
            self.isFavorite = !result
        }).store(in: &cancellables)
    }
    
    func htmlToAttributedString(_ html: String) -> AttributedString? {
        guard let data = html.data(using: .utf8) else { return nil }
        
        do {
            let attributedString = try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
            )
            return AttributedString(attributedString)
        } catch {
            print("Error parsing HTML: \(error)")
            return nil
        }
    }
}
