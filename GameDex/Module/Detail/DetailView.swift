//
//  DetailView.swift
//  GameDex
//
//  Created by Reza Kurniawan on 29/03/25.
//

import SwiftUI
import Kingfisher
import GameDexCore
import Resolver

struct DetailView: View {
    @InjectedObject private var detailViewModel: DetailViewModel
    let id: Int
    
    var body: some View {
        NavigationStack {
            Group {
                if detailViewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                KFImage(detailViewModel.gameDetail?.backgroundImage)
                                    .resizable()
                                    .placeholder {
                                        ProgressView()
                                    }
                                    .frame(width: 120, height: 150)
                                    .scaledToFill()
                                    .clipped()
                                    .cornerRadius(8.0)
                                VStack(alignment: .leading) {
                                    Text(detailViewModel.gameDetail?.name ?? "-")
                                        .bold()
                                    Text(detailViewModel.gameDetail?.genre ?? "-")
                                    Text(DateUtils.convertDateFormat(dateString: detailViewModel.gameDetail?.release ?? "-", fromFormat: "yyyy-MM-dd"))
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .font(.body)
                                        Text(String(format: "%.2f", detailViewModel.gameDetail?.rating ?? 0))
                                    }
                                    Button(action: {
                                        if (detailViewModel.isFavorite) {
                                            detailViewModel.removeFavorite(id)
                                        } else {
                                            detailViewModel.addFavorite(id)
                                        }
                                        
                                    }) {
                                        HStack {
                                            Image(systemName: detailViewModel.isFavorite ? "minus" : "plus")
                                                .font(.body)
                                            
                                            Text("Favorite")
                                                .font(.body.bold())
                                        }
                                        .padding(8)
                                        .foregroundColor(.white)
                                        .background(detailViewModel.isFavorite ? Color.red : Color.blue)
                                        .cornerRadius(12)
                                        .shadow(radius: 3)
                                    }
                                }
                            }
                            if let attributedString = detailViewModel.description {
                                Text(attributedString)
                                    .padding()
                            } else {
                                Text("Failed to parse HTML")
                            }
                        }
                        .padding()
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .navigationTitle("Detail")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            detailViewModel.fetchGameDetail(id)
        }
    }
}

#Preview {
    DetailView(
        id: 2
    )
}
