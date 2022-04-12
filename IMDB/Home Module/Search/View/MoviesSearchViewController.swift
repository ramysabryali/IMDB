//
//  MoviesSearchViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import UIKit

class MoviesSearchViewController: BaseViewController {

    private var viewModel = MoviesSearchViewModel()
    weak var coordinator: TabbarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
