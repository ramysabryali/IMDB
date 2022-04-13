//
//  HomeViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 11/04/2022.
//

import UIKit
import RxCocoa

class HomeViewController: BaseViewController, LoadingDisplayerProtocol {

    private var viewModel = HomeViewModel()
    weak var coordinator: TabbarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindLoadingIndicator(to: viewModel.stateRelay)
        viewModel.fetchAllMoviesData()
    }
}
