//
//  APIConstants.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import Foundation

enum APIConstants: String, CaseIterable {
//    case fetchPhotosList = "/photos?page=%@&&per_page=%@"
    case getConfigurations = "/3/configuration"
    case topRated = "/3/movie/top_rated"
    case popular = "/3/movie/popular"
    case nowPlaying = "/3/movie/now_playing"
    case upComing = "/3/movie/upcoming"
    case movieDetails = "/3/movie/%@"
    case movieSearch = "/3/movie/?type=movie/%@"
}
