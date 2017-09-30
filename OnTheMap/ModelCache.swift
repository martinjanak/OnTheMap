//
//  ModelCache.swift
//  OnTheMap
//
//  Created by Martin Janák on 29/09/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import Foundation

class ModelCache {
    
    // MARK: Instance
    
    static let shared = ModelCache()
    
    // MARK: Models
    
    var user: User?
    var studentLocations = [StudentLocation]()
    
    // MARK: Methods
    
    func loadUser(handler: (() -> Void)?) {
        UdacityClient.shared.getUserData() { user in
            if let user = user {
                self.user = user
            }
            if let handler = handler {
                DispatchQueue.main.async {
                    handler()
                }
            }
        }
    }
    
    func loadStudentLocations(handler: ((Bool) -> Void)?) {
        ParseClient.shared.getStudentLocations() { studentLocations in
            var success = false
            if let studentLocations = studentLocations {
                success = true
                self.studentLocations = studentLocations
            }
            if let handler = handler {
                DispatchQueue.main.async {
                    handler(success)
                }
            }
        }
    }
    
}
