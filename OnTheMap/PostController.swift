//
//  PostController.swift
//  OnTheMap
//
//  Created by Martin Janák on 03/07/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit
import MapKit

class PostController: UIViewController {
    
    var placemark: MKPlacemark?
    
    //  MARK: Location View
    
    lazy var locationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    lazy var locationCancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cancel", for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return btn
    }()
    
    lazy var headerTextView: UITextView = {
        let txt = UITextView()
        txt.isEditable = false
        
        var topText = "Where are you\n"
        var middleText  = "studying\n"
        var bottomText = "today?"
        
        var normalAttrs = [NSFontAttributeName : UIFont.systemFont(ofSize: 24)]
        
        var attributedString = NSMutableAttributedString(string: topText, attributes: normalAttrs)
        
        var boldAttrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 24)]
        var middleString = NSMutableAttributedString(string: middleText, attributes: boldAttrs)
        
        attributedString.append(middleString)
        
        var bottomString = NSMutableAttributedString(string: bottomText, attributes: normalAttrs)
        
        attributedString.append(bottomString)
        
        txt.attributedText = attributedString
        txt.textColor = UIColor.black
        txt.backgroundColor = UIColor.lightGray
        txt.textAlignment = .center
        return txt
    }()
    
    lazy var locationTextField: SmartTextField = {
        let field = SmartTextField()
        field.backgroundColor = UIColor.blue
        field.textColor = UIColor.white
        field.textAlignment = .center
        
        var attributes = [String: AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.white
        let attributedString = NSAttributedString(string: "Tap to enter location", attributes: attributes)
        field.attributedPlaceholder = attributedString
        
        return field
    }()
    
    lazy var findButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Find on the Map", for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(find), for: .touchUpInside)
        return btn
    }()
    
    //  MARK: Link View
    
    lazy var linkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    lazy var linkCancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cancel", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return btn
    }()
    
    lazy var linkTextField: SmartTextField = {
        let field = SmartTextField()
        field.textColor = UIColor.white
        field.textAlignment = .center
        field.text = "http://udacity.com"
        return field
    }()
    
    lazy var mapView: MKMapView = MKMapView()
    
    lazy var submitView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var submitButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Submit", for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return btn
    }()
    
    func cancel() {
        dismiss(animated: true)
    }
    
    func find() {
        if let mapString = locationTextField.text {
            
            Loader.show(controller: self)
            LocationService.search(mapString: mapString) { placemark in
                Loader.hide() {
                    if let placemark = placemark {
                        self.placemark = placemark
                        self.locationView.alpha = 0
                        self.zoomIn(placemark: placemark)
                    } else {
                        Alert.notify(
                            title: "Search failed",
                            message: "Could not find the location.",
                            controller: self
                        )
                    }
                }
            }
        } else {
            Alert.notify(
                title: "Can't search",
                message: "Please make sure you have entered some location.",
                controller: self
            )
        }
    }
    
    func submit() {
        
        Loader.show(controller: self)
        
        if let user = ModelCache.shared.user,
            let placemark = placemark,
            let mediaUrl = linkTextField.text,
            URL(string: mediaUrl) != nil {
            ParseClient.shared.postStudentLocation(user: user, mediaUrl: mediaUrl, placemark: placemark) { response in
                Loader.hide() {
                    if response != nil {
                        self.cancel()
                    } else {
                        Alert.notify(
                            title: "Can't submit",
                            message: "An error occured while sending data to the server.",
                            controller: self
                        )
                    }
                }
            }
        } else {
            Loader.hide() {
                Alert.notify(
                    title: "Can't submit",
                    message: "Please make sure you've entered valid url.",
                    controller: self
                )
            }
        }
    }
    
    func zoomIn(placemark: MKPlacemark) {
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkView.add(linkCancelButton)
        linkView.add(linkTextField)
        linkView.add(mapView)
        linkView.add(submitView)
        submitView.add(submitButton)
        view.add(linkView)
        
        locationView.add(locationCancelButton)
        locationView.add(headerTextView)
        locationView.add(locationTextField)
        locationView.add(findButton)
        view.add(locationView)
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationTextField.subscribeKeyboardListener(contentView: view)
        linkTextField.subscribeKeyboardListener(contentView: view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationTextField.unsubscribeKeyboardListener()
        linkTextField.unsubscribeKeyboardListener()
    }
    
    private func setupConstraints() {
        
        view.constrainContainer(linkView, lead: 0, trail: 0, top: 0, bottom: 0)
        linkView.constrainContainer(linkCancelButton, lead: nil, trail: -10, top: 15, bottom: nil)
        linkView.constrainContainer(linkTextField, lead: 0, trail: 0, top: 40, bottom: nil)
        linkTextField.constrainSize(width: nil, height: 120)
        linkView.constrainContainer(mapView, lead: 0, trail: 0, top: nil, bottom: 0)
        _ = linkView.constrainVertical(from: mapView, to: linkTextField, constant: 0)
        linkView.constrainContainer(submitView, lead: 0, trail: 0, top: nil, bottom: 0)
        submitView.constrainSize(width: nil, height: 100)
        submitButton.constrainSize(width: 200, height: 40)
        submitView.constrainCenter(submitButton, horizontal: 0, vertical: 0)
        
        view.constrainContainer(locationView, lead: 0, trail: 0, top: 0, bottom: 0)
        locationView.constrainContainer(locationCancelButton, lead: nil, trail: -10, top: 15, bottom: nil)
        locationView.constrainContainer(headerTextView, lead: 0, trail: 0, top: 40, bottom: nil)
        headerTextView.constrainSize(width: nil, height: 120)
        locationView.constrainContainer(locationTextField, lead: 0, trail: 0, top: nil, bottom: -100)
        _ = locationView.constrainVertical(from: locationTextField, to: headerTextView, constant: 0)
        findButton.constrainSize(width: 200, height: 40)
        locationView.constrainCenter(findButton, horizontal: 0, vertical: nil)
        _ = locationView.constrainBottom(findButton, constant: -30)
    }
}
