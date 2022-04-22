//
//  MovieGroupType.swift
//  IMDB
//
//  Created by Ramy Sabry on 22/04/2022.
//

enum MovieGroupType {
    //        case topSlide = ""
    case topRated
    case mostPopular
    case nowPlaying
    case upcoming
}

extension MovieGroupType {
    var title: String {
        switch self {
        case .topRated:
            return "Top rated"
            
        case .mostPopular:
            return "Most popular"
            
        case .nowPlaying:
            return "Now playing"
            
        case .upcoming:
            return "Upcoming"
        }
    }
}
