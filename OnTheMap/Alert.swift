//
//  Alert.swift
//  OnTheMap
//
//  Created by Martin Janák on 17/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

class Alert {
    
    static func notify(title: String, message: String, controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        controller.present(alertController, animated: true)
    }
    
}
