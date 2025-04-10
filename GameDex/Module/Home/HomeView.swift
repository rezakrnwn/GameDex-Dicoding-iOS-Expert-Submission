//
//  HomeView.swift
//  GameDex
//
//  Created by Reza Kurniawan on 29/03/25.
//

import SwiftUI
import Resolver
import GameDexCore

struct HomeView: View {
    @InjectedObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if (homeViewModel.isLoading) {
                    ProgressView()
                } else if (homeViewModel.errorMessage != nil) {
                    Text(homeViewModel.errorMessage ?? "Oops something error")
                } else {
                    List(homeViewModel.games) { item in
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
            .navigationTitle("GameDex")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: FavoriteView(), label: {
                        Text("Favorite")
                    })
                }
            }
        }
        .onAppear {
            homeViewModel.fetchGames()
        }
    }
}

#Preview {
    HomeView()
}
