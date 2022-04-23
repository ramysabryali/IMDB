//
//  HomeSectionRowData.swift
//  IMDB
//
//  Created by Ramy Sabry on 22/04/2022.
//

import RxSwift

struct HomeSectionRowData {
    var moviesSubject: BehaviorSubject<[MovieData]>
    var movieGroupType: MovieGroupType
    var sectionType: HomeSectionType
    
    init(
        movies: [MovieData],
        movieGroupType: MovieGroupType,
        sectionType: HomeSectionType
    ) {
        self.moviesSubject = .init(value: movies)
        self.movieGroupType = movieGroupType
        self.sectionType = sectionType
    }
}

enum HomeSectionType {
    case featuredToday
    case whatToWatch
    case watchFree
}

extension HomeSectionType {
    var title: String {
        switch self {
        case .featuredToday:
            return "Featured today"
            
        case .whatToWatch:
            return "What to watch"
            
        case .watchFree:
            return "Watch free on IMDb"
        }
    }
}
