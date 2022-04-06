//
//  View+Helpers.swift
//  ADVA Photos Task
//
//  Created by Ramy Sabry on 04/04/2022.
//

import UIKit

extension UIView {
    /// Returns the Nib associated with the received: It's filename is expected to match the Class Name
    class func loadNib() -> UINib {
        return UINib(nibName: classNameWithoutNamespaces, bundle: nil)
    }
}
