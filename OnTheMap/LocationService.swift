//
//  LocationService.swift
//  OnTheMap
//
//  Created by Martin Janák on 29/09/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import Foundation
import MapKit

class LocationService {
    
    static func search(mapString: String, handler: @escaping (MKPlacemark?) -> Void) {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = mapString
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            if let mapItems = response?.mapItems,
                mapItems.count > 0 {
                let placemark = mapItems[0].placemark
                handler(placemark)
            } else {
                handler(nil)
            }
        }
    }
    
}
