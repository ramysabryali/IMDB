//
//  LoginViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 09/04/2022.
//

import UIKit

class LoginViewController: BaseViewController {

    private var viewModel = LoginViewModel()
    weak var coordinator: RegistrationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonAction(sender: UIButton) {
        CredentialManager.shared.set(userName: "Ramy Sabry")
        coordinator?.finish()
    }
}
