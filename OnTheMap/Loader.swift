//
//  Loader.swift
//  OnTheMap
//
//  Created by Martin Janák on 17/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

class Loader: UIViewController {
    
    static var instance: Loader = Loader()
    
    static func show(controller: UIViewController) {
        instance.modalPresentationStyle = .overFullScreen
        instance.modalTransitionStyle = .crossDissolve
        instance.activityIndicatorView.startAnimating()
        controller.present(instance, animated: true, completion: nil)
    }
    
    static func hide(handler: (() -> Void)?) {
        instance.dismiss(animated: true) {
            instance.activityIndicatorView.stopAnimating()
            if let handler = handler {
                handler()
            }
        }
    }
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.textDark.withAlphaComponent(0.8)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        Constrain.center(child: activityIndicatorView, parent: view, horizontal: true, vertical: true)
    }
    
}
