//
//  APIService.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 28/03/2022.
//

import Foundation
import Combine
import Security

final class APIService: NSObject {
    
    static let shared = APIService()
        
    private(set) lazy var session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = NetworkConstants.timeoutIntervalForRequest
        return URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    }()
    
    private let serviceQueue: DispatchQueue
    
    // MARK: - Init
    private override init() {
        self.serviceQueue = .init(
            label: "service",
            qos: .userInteractive,
            attributes: .concurrent
        )
        super.init()
    }
}

extension APIService: APIServiceContract {
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = .init(),
        retry: Int = NetworkConstants.retries
    ) -> AnyPublisher<T, BaseError> {
        
        return session
            .dataTaskPublisher(for: request)
            .retry(retry)
            .print()
            .tryMap { response in
                guard
                    let httpResponse = response.response as? HTTPURLResponse
                else {
                    throw URLError(.badServerResponse)
                }
                
                let statusCode: Int = httpResponse.statusCode
                
                guard NetworkConstants.Range.statusCode.contains(statusCode) else {
                    throw ErrorResolver.shared.getError(code: statusCode)
                }
                
                return response.data
            }
            .receive(on: serviceQueue)
            .decode(type: T.self, decoder: decoder)
            .mapError(handleError(using:))
            .eraseToAnyPublisher()
    }
}

private extension APIService {
    func handleError(using error: Error) -> BaseError {
        switch error {
        case URLError.networkConnectionLost,
            URLError.notConnectedToInternet:
            return ErrorResolver.shared.getError(for: .connection)
            
        case is URLError:
            return ErrorResolver.shared.getError(for: .unwrappedHttpServer)
            
        case is DecodingError:
            return ErrorResolver.shared.getError(for: .mapping)
            
        default:
            return ErrorResolver.shared.getError(with: error)
        }
    }
}
