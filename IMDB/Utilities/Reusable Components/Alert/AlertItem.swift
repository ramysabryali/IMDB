//
//  AlertItem.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 29/03/2022.
//

import UIKit

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String?
    let message: String?
    let style: UIAlertController.Style
    let actions: [AlertAction]
    
    init(
        title: String? = nil,
        message: String?,
        style: UIAlertController.Style = .alert,
        actions: [AlertAction] = []
    ) {
        self.title = title
        self.message = message
        self.style = style
        self.actions = actions
    }
}

extension AlertItem: Equatable {
    static func == (lhs: AlertItem, rhs: AlertItem) -> Bool {
        lhs.id == rhs.id
    }
}
