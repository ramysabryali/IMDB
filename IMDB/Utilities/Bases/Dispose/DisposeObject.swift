//
//  DisposeObject.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import RxSwift

class DisposeObject {
    var deinitCalled: (() -> Void)?
    var disposeBag: DisposeBag
    
    init() {
        self.disposeBag = DisposeBag()
    }
    
    deinit {
        deinitCalled?()
    }
}
