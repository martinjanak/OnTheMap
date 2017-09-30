//
//  User.swift
//  OnTheMap
//
//  Created by Martin Janák on 29/09/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import Foundation

class User {
    
    let key: String
    let firstName: String
    let lastName: String
    
    init(key: String, firstName: String, lastName: String) {
        self.key = key
        self.firstName = firstName
        self.lastName = lastName
    }
    
}
