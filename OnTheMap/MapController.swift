//
//  MapController.swift
//  OnTheMap
//
//  Created by Martin Janák on 17/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit
import MapKit

class MapController: MainController, MKMapViewDelegate {
    
    lazy var mapView: MKMapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        view.add(mapView)
        
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    private func setupConstraints() {
        view.constrainContainer(mapView, lead: 0, trail: 0, top: 0, bottom: 0)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let annotation = view.annotation,
                let urlString = annotation.subtitle as? String,
                let url = URL(string: urlString) {
                app.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func refresh() {
        super.refresh()
        ModelCache.shared.loadStudentLocations() { success in
            
            if success {
                let studentLocations = ModelCache.shared.studentLocations
                var annotations = [MKAnnotation]()
                for studentLocation in studentLocations {
                    annotations.append(studentLocation.getAnnotation())
                }
                self.clearAnnotations()
                self.mapView.addAnnotations(annotations)
            } else {
                Alert.notify(
                    title: "Student locations error",
                    message: "Was unnable to load student locations.",
                    controller: self
                )
            }
        }
    }
    
    private func clearAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
    }
}
