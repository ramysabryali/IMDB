//
//  HomeViewModel.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import Foundation
import RxSwift

final class HomeViewModel: BaseViewModel {
    private let apiService: APIServiceContract
    
    init(apiService: APIServiceContract = APIService.shared) {
        self.apiService = apiService
        super.init()
    }
    
    func fetchData() {
        //        .setPath(using: .topRated, argument: ["\(1)", "\(10)"])
        let request = APIBuilder()
            .setPath(using: .topRated)
            .setMethod(using: .get)
            .setAPIKey()
            .build()
        
        apiService.request(using: request, responseType: MoviesResponse.self)
            .subscribe(
                onNext: { result in
                    switch result {
                    case .success(let movies):
                        dump(movies)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            ).disposed(by: disposeBag)
    }
}
