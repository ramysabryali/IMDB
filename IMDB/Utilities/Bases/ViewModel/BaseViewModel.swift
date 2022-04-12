//
//  BaseViewModel.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import RxSwift
import RxRelay

class BaseViewModel: DisposeObject {
    var stateRelay = BehaviorRelay<ViewModelState<BaseError>>.init(value: .idle)
    var alertItemRelay = BehaviorRelay<AlertItem?>.init(value: nil)
}
