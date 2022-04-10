//
//  APIService.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 28/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class APIService: NSObject, APIServiceContract {
    static let shared = APIService()
    
    private override init() {}
    
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = .init(),
        retry: Int = NetworkConstants.retries
    ) -> Observable<Result<T, BaseError>> {
        return Observable.create { observer in
            URLSession
                .shared
                .rx
                .response(request: request)
                .debug(request.url?.absoluteString)
                .subscribe(
                    onNext: { response in
                        let statusCode: Int = response.response.statusCode
                        
                        guard NetworkConstants.Range.statusCode.contains(statusCode) else {
                            observer.onNext(.failure(ErrorResolver.shared.getError(code: statusCode)))
                            observer.onCompleted()
                            return
                        }
                        
                        guard let decoded = try? decoder.decode(responseType, from: response.data) else {
                            observer.onNext(.failure(ErrorResolver.shared.getError(for: .mapping)))
                            observer.onCompleted()
                            return
                        }
                        
                        return observer.onNext(.success(decoded))
                    },
                    onError: { [weak self] error in
                        guard let self = self else { return }
                        observer.onNext(.failure(self.handleError(using: error)))
//                        observer.onError(error)
                        observer.onCompleted()
                    }
                )
        }
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
