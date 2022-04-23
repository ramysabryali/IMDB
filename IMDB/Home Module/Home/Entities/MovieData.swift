//
//  MovieData.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import Foundation

struct MovieData: Decodable {
    let id: Int
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension MovieData {
    var posterFullURL: String? {
        guard let posterPath: String = posterPath else { return nil }
        return AppConfigurationsManager.shared.imageBaseUrl + ImageSize.w500.rawValue + posterPath
    }
}
