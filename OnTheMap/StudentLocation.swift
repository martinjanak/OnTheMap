//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Martin Janák on 28/09/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import Foundation
import MapKit

class StudentLocation {
    
    let firstName: String
    let lastName: String
    let mediaUrl: String
    
    let latitude: Double
    let longitude: Double
    
    init(firstName: String, lastName: String, mediaUrl: String, latitude: Double, longitude: Double) {
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
