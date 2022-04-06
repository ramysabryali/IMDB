//
//  DisposeObject.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import Combine

class DisposeObject {
    var deinitCalled: (() -> Void)?
    var cancellables: Set<AnyCancellable>
    
    init() {
        self.cancellables = Set<AnyCancellable>()
    }
    
    deinit {
        self.cancellables.removeAll()
        deinitCalled?()
    }
}
