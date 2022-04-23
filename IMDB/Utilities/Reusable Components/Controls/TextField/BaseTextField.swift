//
//  BaseTextField.swift
//  IMDB
//
//  Created by Ramy Sabry on 24/04/2022.
//

import UIKit

@IBDesignable
final class BaseTextField: UITextField {
    
    @IBInspectable
    var padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyStyle()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func applyStyle() {
        attributedPlaceholder = NSAttributedString(
            string: self.placeholder.value,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.Controls.BaseTextfield.textfieldPlaceHolderColor]
        )
        
        backgroundColor = UIColor.Controls.BaseTextfield.textfieldBackgroundColor
        textColor = UIColor.Core.constantBlackColor
    }
}
