//
//  SplashViewModel.swift
//  IMDB
//
//  Created by Ramy Sabry on 23/04/2022.
//

import RxSwift

final class SplashViewModel: BaseViewModel {
    private let apiService: APIServiceContract
    private let appConfigurationsManager: AppConfigurationsProtocol
    
    var onCompleteSubject = PublishSubject<Void>()
    
    init(
        appConfigurationsManager: AppConfigurationsProtocol = AppConfigurationsManager.shared,
        apiService: APIServiceContract = APIService.shared
    ) {
        self.appConfigurationsManager = appConfigurationsManager
        self.apiService = apiService
        super.init()
    }
}

// MARK: - Input Methods

extension SplashViewModel {
    func loadConfigurations() {
        let request = APIBuilder()
            .setPath(using: .getConfigurations)
            .setMethod(using: .get)
            .setAPIKey()
            .build()
        
        apiService
            .request(
                using: request,
                responseType: LoadConfigurationsResponse.self
            )
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                
                if case let .failure(error) = result {
                    self.stateRelay.accept(.failed(error))
                    self.alertItemRelay.accept(.init(message: error.message))
                    return
                }
                
                guard case let .success(response) = result else { return }
                self.handleOonCompleteFetching(configurations: response)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private Methods

private extension SplashViewModel {
    func handleOonCompleteFetching(configurations: LoadConfigurationsResponse) {
        guard let imagesConfig: ImagesConfiguration = configurations.images else {
            self.alertItemRelay.accept(.init(message: "Unexpected error, try again later"))
            return
        }
        
        appConfigurationsManager.set(imagesConfg: imagesConfig)
        onCompleteSubject.onNext(())
    }
}
