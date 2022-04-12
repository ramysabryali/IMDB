//
//  VideosViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import UIKit

class VideosViewController: BaseViewController {

    private var viewModel = VideosViewModel()
    weak var coordinator: TabbarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
