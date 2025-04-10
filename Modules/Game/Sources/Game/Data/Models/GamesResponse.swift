//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import Foundation

// MARK: - GamesResponse
struct GamesResponse: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [ResultGamesResponse]
    let seoTitle, seoDescription, seoKeywords, seoH1: String
    let noindex, nofollow: Bool
    let gamesResponseDescription: String
    let filters: Filters
    let nofollowCollections: [String]
    
    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow
        case gamesResponseDescription = "description"
        case filters
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Filters
struct Filters: Codable {
    let years: [FiltersYear]
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    let from, to: Int
    let filter: String
    let decade: Int
    let years: [YearYear]
    let nofollow: Bool
    let count: Int
}

// MARK: - YearYear
struct YearYear: Codable {
    let year, count: Int
    let nofollow: Bool
}

// MARK: - Result
struct ResultGamesResponse: Codable {
    let id: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let ratingsCount, reviewsTextCount, added: Int
    let addedByStatus: AddedByStatus
    let metacritic, playtime, suggestionsCount: Int
    let updated: String
    let reviewsCount: Int
    let saturatedColor, dominantColor: String
    let platforms: [PlatformElement]
    let parentPlatforms: [ParentPlatform]
    let genres: [Genre]
    let stores: [Store]
    let tags: [Genre]
    let esrbRating: EsrbRating
    let shortScreenshots: [ShortScreenshot]
    
    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, stores, tags
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int
    let dropped, playing: Int
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int
    let name, slug: String
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?
    let language: Language?
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

enum Language: String, Codable {
    case eng = "eng"
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    let platform: EsrbRating
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformPlatform
    let releasedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int
    let name, slug: String
    let image, yearEnd: String?
    let yearStart: Int?
    let gamesCount: Int
    let imageBackground: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}

// MARK: - Store
struct Store: Codable {
    let id: Int
    let store: Genre
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

extension ResultGamesResponse {
    func toGameEntity() -> Game {
        return Game(id: id, name: name, release: released, rating: rating, backgroundImage: URL(string: backgroundImage)!)
    }
}
