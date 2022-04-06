//
//  APIServiceContract.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 28/03/2022.
//

import Foundation
import Combine

protocol APIServiceContract {
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder,
        retry: Int
    ) -> AnyPublisher<T, BaseError>
}

// MARK: - APIServiceContract+Handle request func default implementation

extension APIServiceContract {
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type
    ) -> AnyPublisher<T, BaseError> {
        self.request(
            using: request,
            responseType: responseType,
            decoder: JSONDecoder(),
            retry: NetworkConstants.retries
        )
    }
}
