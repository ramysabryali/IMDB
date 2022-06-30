//
//  AlertDisplayer.swift
//  IMDB
//
//  Created by Ramy Sabry on 29/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol AlertDisplayerProtocol {
    func showAlert(with alertItem: AlertItem?)
}

extension AlertDisplayerProtocol where Self: BaseViewController {
    func bindAlert(to alertItem: BehaviorRelay<AlertItem?>) {
        alertItem.subscribe { [weak self] alertItem in
            guard let self = self else { return }
            guard let alertItem = alertItem.element else { return }
            
            self.showAlert(with: alertItem)
        }
        .disposed(by: disposeBag)
    }
    
    func showAlert(with alertItem: AlertItem?) {
        guard let alertItem = alertItem else { return }
        
        let alertController = UIAlertController(
            title: alertItem.title,
            message: alertItem.message,
            preferredStyle: alertItem.style
        )
        
        alertItem.actions.forEach { action in
            alertController.addAction(
                action.toUIAlertAction
            )
        }
        
        self.startPresentationTimerIfNeeded(with: alertItem, for: alertController)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func startPresentationTimerIfNeeded(
        with alertItem: AlertItem,
        for alertController: UIAlertController
    ) {
        guard alertItem.actions.isEmpty == false else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}
