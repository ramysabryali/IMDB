//
//  HomeViewModel.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import RxSwift
import RxDataSources

enum HomeViewSections {
//        case topSlide = ""
    case topRated
    case mostPopular
    case nowPlaying
    case upcoming
}

extension HomeViewSections {
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

struct HomeSectionRowItem {
    var items: [Int]
//    var movies: [MovieData]
    var movies: PublishSubject<[MovieData]>
    var type: HomeViewSections
    
    init(
        items: [Int],
        movies: [MovieData],
        type: HomeViewSections
    ) {
        self.items = items
        self.movies = .init()
        self.movies.onNext(movies)
        self.type = type
    }
}

extension HomeSectionRowItem: SectionModelType {
    typealias Item = Int

    init(original: HomeSectionRowItem, items: [Item]) {
        self = original
        self.items = items
    }
}

//struct HomeSectionRowItem {
//    var movies: PublishSubject<[MovieData]>
//}

final class HomeViewModel: BaseViewModel {
    private let apiService: APIServiceContract
//    private let pageSize: Int = Constants.pageSize
//    private var page: Int = 1
    
    private(set) var sections = PublishSubject<[HomeSectionRowItem]>()
    
//    private(set) var topRatedMovies = PublishSubject<[MovieData]>()
//    var popularMovies: [MovieData] = []
//    var nowPlayingMovies: [MovieData] = []
//    var upComingMovies: [MovieData] = []
    
    init(apiService: APIServiceContract = APIService.shared) {
        self.apiService = apiService
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
                
                // Check for error
                if let error: BaseError =  self.getErrorIfExist(
                    from: [topRatedResult, popularResult, nowPlayingResult, upcomingResult]
                ) {
                    self.stateRelay.accept(.failed(error))
                    self.alertItemRelay.accept(.init(message: error.message))
                    return
                }
                
                // Handle success
                self.sections.onNext(
                    [
                        .init(
                            items: [1],
                            movies: self.getMoviesListIfExist(from: topRatedResult),
                            type: .topRated
                        ),
                        .init(
                            items: [1],
                            movies: self.getMoviesListIfExist(from: popularResult),
                            type: .mostPopular
                        ),
                        .init(
                            items: [1],
                            movies: self.getMoviesListIfExist(from: nowPlayingResult),
                            type: .nowPlaying
                        ),
                        .init(
                            items: [1],
                            movies: self.getMoviesListIfExist(from: upcomingResult),
                            type: .upcoming
                        )
                    ]
                )
                
//                self.topRatedMovies.onNext(
//                    self.getMoviesListIfExist(from: topRatedResult)
//                )
//                self.popularMovies.append(
//                    contentsOf: self.getMoviesListIfExist(from: popularResult)
//                )
//                self.nowPlayingMovies.append(
//                    contentsOf: self.getMoviesListIfExist(from: nowPlayingResult)
//                )
//                self.upComingMovies.append(
//                    contentsOf: self.getMoviesListIfExist(from: upcomingResult)
//                )
                
                self.stateRelay.accept(.successful)
            }.disposed(by: disposeBag)
    }
}

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
            let movies: [MovieData] = moviesResponse.results
        else {
            return []
        }
        
        return movies
    }
}
