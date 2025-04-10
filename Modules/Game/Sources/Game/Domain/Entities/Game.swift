//
//  File.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import Foundation

public struct Game: Identifiable {
    public let id: Int
    public let name: String
    public let release: String
    public let rating: Double
    public let backgroundImage: URL
}
