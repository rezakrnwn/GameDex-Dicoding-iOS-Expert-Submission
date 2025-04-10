//
//  FavoriteView.swift
//  GameDex
//
//  Created by Reza Kurniawan on 29/03/25.
//

import SwiftUI
import Resolver
import GameDexCore

struct FavoriteView: View {
    @InjectedObject var favoriteViewModel: FavoriteViewModel
    
    var body: some View {
        NavigationStack {
            if (favoriteViewModel.isLoading) {
                ProgressView()
            } else {
                if (favoriteViewModel.favorites.isEmpty) {
                    Text("Favorite is empty")
                } else {
                    List(favoriteViewModel.favorites) { item in
                        GameItemView(
                            id: item.id,
                            name: item.name,
                            backgroundImage: item.backgroundImage,
                            releaseDate: DateUtils.convertDateFormat(dateString: item.release, fromFormat: "yyyy-MM-dd"),
                            rating: item.rating,
                            destination: AnyView(DetailView(id: item.id))
                        )
                    }
                }
            }
        }
        .navigationTitle("Favorite")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            favoriteViewModel.getFavorites()
        }
    }
}

#Preview {
    FavoriteView()
}
