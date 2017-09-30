//
//  BaseTextField.swift
//  OnTheMap
//
//  Created by Martin Janák on 30/09/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {
    
    init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        // override by implementations
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    
}

// MARK: Insets
extension BaseTextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
    }
    
}
