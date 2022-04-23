//
//  LoginViewModel.swift
//  IMDB
//
//  Created by Ramy Sabry on 09/04/2022.
//

import RxSwift

final class LoginViewModel: BaseViewModel {
    private let credentialsManager: CredentialsProtocol
    
    init(credentialsManager: CredentialsProtocol = CredentialManager.shared) {
        self.credentialsManager = credentialsManager
        super.init()
    }
}
