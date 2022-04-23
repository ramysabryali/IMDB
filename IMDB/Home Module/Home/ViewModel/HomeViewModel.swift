//
//  HomeViewModel.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import RxSwift

final class HomeViewModel: BaseViewModel {
    private let apiService: APIServiceContract
    private(set) var sections: PublishSubject<[HomeSectionRowItem]>
    private var maxMoviesNumberPerSection: Int?
    //    private let pageSize: Int = Constants.pageSize
    //    private var page: Int = 1
    
    init(
        maxMoviesNumberPerSection: Int? = 8,
        apiService: APIServiceContract = APIService.shared
    ) {
        self.maxMoviesNumberPerSection = maxMoviesNumberPerSection
        self.apiService = apiService
        self.sections = .init()
        super.init()
    }
    
    func fetchAllMoviesData() {
        stateRelay.accept(.loading)
        
        let topRatedMoviesObservable = fetchMovies(for: .topRated)
        let popularMoviesObservable = fetchMovies(for: .popular)
        let nowPlayingMoviesObservable = fetchMovies(for: .nowPlaying)
        let upcomingMoviesObservable = fetchMovies(for: .upComing)
        
        Observable.zip(
            topRatedMoviesObservable,
            popularMoviesObservable,
            nowPlayingMoviesObservable,
            upcomingMoviesObservable
        )
            .subscribe { [weak self]
                topRatedResult,
                popularResult,
                nowPlayingResult,
                upcomingResult in
                
                guard let self = self else { return }
                
                self.handleOnCompleteFetchingMovies(
                    using: topRatedResult,
                    and: popularResult,
                    and: nowPlayingResult,
                    and: upcomingResult
                )
                //                self.sections.onCompleted()
            }.disposed(by: disposeBag)
    }
}

// MARK: - Private Methods

private extension HomeViewModel {
    func fetchMovies(for type: APIConstants) -> Observable<Result<MoviesResponse, BaseError>> {
        let request = APIBuilder()
            .setPath(using: type)
            .setMethod(using: .get)
            .setAPIKey()
            .build()
        
        return apiService
            .request(
                using: request,
                responseType: MoviesResponse.self
            )
    }
    
    func handleOnCompleteFetchingMovies(
        using topRatedResult: Result<MoviesResponse, BaseError>,
        and popularResult: Result<MoviesResponse, BaseError>,
        and nowPlayingResult: Result<MoviesResponse, BaseError>,
        and upcomingResult: Result<MoviesResponse, BaseError>
    ) {
        // Check for error
        if let error: BaseError =  getErrorIfExist(
            from: [topRatedResult, popularResult, nowPlayingResult, upcomingResult]
        ) {
            stateRelay.accept(.failed(error))
            alertItemRelay.accept(.init(message: error.message))
            return
        }
        
        // Handle success
        let topRatedMovies: [MovieData] = getMoviesListIfExist(from: topRatedResult)
        let mostPopularMovies: [MovieData] = getMoviesListIfExist(from: popularResult)
        let nowPlayingMovies: [MovieData] = getMoviesListIfExist(from: nowPlayingResult)
        let upcomingMovies: [MovieData] = getMoviesListIfExist(from: upcomingResult)
        sections
            .onNext([
                .init(items: [.init(movies: topRatedMovies, movieGroupType: .topRated)]),
                .init(items: [.init(movies: mostPopularMovies, movieGroupType: .mostPopular)]),
                .init(items: [.init(movies: nowPlayingMovies, movieGroupType: .nowPlaying)]),
                .init(items: [.init(movies: upcomingMovies, movieGroupType: .upcoming)])
            ])
        
        stateRelay.accept(.successful)
    }
    
    func getErrorIfExist(
        from results: [Result<MoviesResponse, BaseError>]
    ) -> BaseError? {
        for result in results {
            if case let .failure(error) = result {
                return error
            }
        }
        
        return nil
    }
    
    func getMoviesListIfExist(
        from response: Result<MoviesResponse, BaseError>
    ) -> [MovieData] {
        guard
            case let .success(moviesResponse) = response,
            var movies: [MovieData] = moviesResponse.results
        else {
            return []
        }
        
        return getMaxNumber(of: &movies)
    }
    
    func getMaxNumber(of movies: inout [MovieData]) -> [MovieData] {
        guard let maxMoviesNumberPerSection = maxMoviesNumberPerSection else {
            return movies
        }
        
        return Array(movies.prefix(maxMoviesNumberPerSection))
    }
}
