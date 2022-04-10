//
//  APIServiceContract.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 28/03/2022.
//

import Foundation
import RxSwift

protocol APIServiceContract {
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder,
        retry: Int
    ) -> Observable<Result<T, BaseError>>
}

extension APIServiceContract {
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = .init(),
        retry: Int = NetworkConstants.retries
    ) -> Observable<Result<T, BaseError>> {
        self.request(
            using: request,
            responseType: responseType,
            decoder: JSONDecoder(),
            retry: NetworkConstants.retries
        )
    }
}
