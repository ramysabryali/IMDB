//
//  LoginViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 09/04/2022.
//

import UIKit

class LoginViewController: BaseViewController, LoadingDisplayerProtocol {
    
    @IBOutlet weak var createNewAccountButton: BaseButton!
    @IBOutlet weak var signInButton: BaseButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var passwordTextfield: BaseTextField!
    @IBOutlet weak var emailTextfield: BaseTextField!
    
    private var viewModel = LoginViewModel()
    weak var coordinator: RegistrationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindLoadingIndicator(to: viewModel.stateRelay)
        setButtonsStyle()
    }
    
    @IBAction func loginButtonAction(sender: UIButton) {
        // TODO: - To be removed
        CredentialManager.shared.set(value: "Ramy Sabry", for: .username)
        coordinator?.finish()
    }
}

// MARK: - Private Methods

private extension LoginViewController {
    func setButtonsStyle() {
        createNewAccountButton.customStyle = .seconday
    }
}
