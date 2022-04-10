//
//  LoginViewModel.swift
//  IMDB
//
//  Created by Ramy Sabry on 09/04/2022.
//

import Foundation
import RxSwift

class LoginViewModel {
    let apiService = APIService.shared
    let disposeBag = DisposeBag()
    
    init() {
        
    }
    
    func fetchData() {
        let request = APIBuilder()
            .setPath(using: .fetchPhotosList, argument: ["\(1)", "\(10)"])
            .setMethod(using: .get)
            .build()
        
        apiService.request(using: request, responseType: [PhotoData].self)
            .subscribe(
                onNext: { result in
                    switch result {
                    case .success(let movies):
                        print("\nCount = ", movies.count)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }, onError: { error in
                    print(error)
                }
            ).disposed(by: disposeBag)
    }
}

struct PhotoData: Decodable {
    let id: String
    let createdAt: String?
    let updatedAt: String?
    let promotedAt: String?
    let width: Float?
    let height: Float?
    let color: String?
    let blurHash: String?
    let welcomeDescription: String?
    let altDescription: String?
//    let urls: PhotoURLs?
//    let links: PhotoDownloadLinks?
    let likes: Int?
    let likedByUser: Bool?
//    let sponsorship: PhotoSponsorship?
//    let user: PhotoOwner?
}
