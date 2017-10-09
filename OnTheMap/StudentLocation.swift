//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Martin Janák on 28/09/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import Foundation
import MapKit

struct StudentLocation {
    
    let firstName: String
    let lastName: String
    let mediaUrl: String
    
    let latitude: Double
    let longitude: Double
    
    init?(_ data: [String: AnyObject]) {
        
        guard let firstName = data["firstName"] as? String,
            let lastName = data["lastName"] as? String,
            let mediaUrl = data["mediaURL"] as? String,
            let latitude = data["latitude"] as? Double,
            let longitude = data["longitude"] as? Double else {
                return nil
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.mediaUrl = mediaUrl
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getAnnotation() -> MKPointAnnotation {
        
        let lat = CLLocationDegrees(latitude)
        let long = CLLocationDegrees(longitude)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(firstName) \(lastName)"
        annotation.subtitle = mediaUrl
        return annotation
    }
    
}
