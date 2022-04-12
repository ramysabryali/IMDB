//
//  ProfileViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import UIKit

class ProfileViewController: BaseViewController {
    private var viewModel = ProfileViewModel()
    weak var coordinator: ProfileCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutButtonAction(sender: UIButton) {
        CredentialManager.shared.delete(service: .username)
        coordinator?.finish()
    }
}
