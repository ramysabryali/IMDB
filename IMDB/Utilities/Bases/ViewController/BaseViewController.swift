//
//  BaseViewController.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 04/04/2022.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    deinit {
        print("deinit ", self.self)
    }
}
