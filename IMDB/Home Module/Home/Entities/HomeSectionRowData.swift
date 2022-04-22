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
    
    init(
        movies: [MovieData],
        movieGroupType: MovieGroupType
    ) {
        self.moviesSubject = .init(value: movies)
        self.movieGroupType = movieGroupType
    }
}
