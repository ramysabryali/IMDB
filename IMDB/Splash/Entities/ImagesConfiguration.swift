//
//  ImagesConfiguration.swift
//  IMDB
//
//  Created by Ramy Sabry on 23/04/2022.
//

import Foundation

struct ImagesConfiguration: Decodable {
    let baseURL: String?
    let secureBaseURL: String?
    let backdropSizes: [ImageSize]?
    let logoSizes: [ImageSize]?
    let posterSizes: [ImageSize]?
    let profileSizes: [ImageSize]?
    let stillSizes: [ImageSize]?

    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}
