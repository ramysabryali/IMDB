//
//  SplashViewController.swift
//  IMDB
//
//  Created by Ramy Sabry on 23/04/2022.
//

import UIKit
import RxSwift

class SplashViewController: BaseViewController {

    private var viewModel = SplashViewModel()
    weak var coordinator: SplashCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeOnCompleteSubject()
        viewModel.loadConfigurations()
    }
    
    func subscribeOnCompleteSubject() {
        viewModel
            .onCompleteSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.presentHomeView()
            })
            .disposed(by: disposeBag)
    }
}
