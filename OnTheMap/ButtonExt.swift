//
//  ButtonExt.swift
//  OnTheMap
//
//  Created by Martin Janák on 29/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

extension UIButton {

    func set(enabled: Bool) {
        self.isEnabled = enabled
        self.alpha = enabled ? 1.0 : 0.5
    }
    
}
