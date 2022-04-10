//
//  LoginViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 09/04/2022.
//

import UIKit

class LoginViewController: BaseViewController {

    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
    }
}
