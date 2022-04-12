//
//  VideoViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 12/04/2022.
//

import UIKit

class VideoViewController: BaseViewController {

    private var viewModel = VideoViewModel()
    weak var coordinator: TabbarCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }
}
