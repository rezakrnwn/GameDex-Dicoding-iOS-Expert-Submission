//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 08/04/25.
//

import Foundation
import RealmSwift

class GameFavoriteEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var release: String
    @Persisted var rating: Double
    @Persisted var backgroundImage: String
}

extension GameFavoriteEntity {
    func toFavoriteDomain() -> GameFavorite {
        return GameFavorite(
            id: id, name: name, release: release, rating: rating, backgroundImage: URL(string: backgroundImage)!
        )
    }
}
