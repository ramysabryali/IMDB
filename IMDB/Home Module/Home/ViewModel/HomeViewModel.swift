//
//  HomeViewModel.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import RxSwift

final class HomeViewModel: BaseViewModel {
    private let apiService: APIServiceContract
    private let pageSize: Int = Constants.pageSize
    private var page: Int = 1
    
    var topRatedMovies: [MovieData] = []
    
    init(apiService: APIServiceContract = APIService.shared) {
        self.apiService = apiService
        super.init()
    }
    
    func fetchData() {
        //        .setPath(using: .topRated, argument: ["\(1)", "\(10)"])
        fetchTopRatedMovies()
    }
}

private extension HomeViewModel {
    func fetchTopRatedMovies() {
        stateRelay.accept(.loading)
        
        let request = APIBuilder()
            .setPath(using: .topRated)
            .setMethod(using: .get)
            .setAPIKey()
            .build()
        
        apiService.request(using: request, responseType: MoviesResponse.self)
            .subscribe(
                onNext: { [weak self] result in
                    guard let self = self else { return }
                    
                    if case let .failure(error) = result {
                        self.stateRelay.accept(.failed(error))
                        self.alertItemRelay.accept(.init(message: error.message))
                        return
                    }
                    
                    guard
                        case let .success(response) = result,
                        let topRatedMovies: [MovieData] = response.results
                    else { return }
                    
                    self.topRatedMovies.append(contentsOf: topRatedMovies)
                    self.stateRelay.accept(.successful)
                }
            ).disposed(by: disposeBag)
    }
}
