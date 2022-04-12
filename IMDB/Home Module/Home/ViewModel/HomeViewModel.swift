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
}
