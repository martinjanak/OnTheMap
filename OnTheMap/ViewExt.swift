//
//  ViewExt.swift
//  OnTheMap
//
//  Created by Martin Janák on 29/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

extension UIView {
    
    func add(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
