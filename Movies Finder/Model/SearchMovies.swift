//
//  MoviesSearch.swift
//  Movies Finder
//
//  Created by Noel Conde Algarra on 27/11/21.
//

import Foundation

// MARK: - Search
struct SearchResult: Codable {
    let search: [SearchMovie]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - SearchMovie
struct SearchMovie: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
    case episode = "episode"
}
