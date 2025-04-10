//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation

public struct GameFavorite: Identifiable {
    public let id: Int
    public let name: String
    public let release: String
    public let rating: Double
    public let backgroundImage: URL
    
    public init(id: Int, name: String, release: String, rating: Double, backgroundImage: URL) {
        self.id = id
        self.name = name
        self.release = release
        self.rating = rating
        self.backgroundImage = backgroundImage
    }
}
