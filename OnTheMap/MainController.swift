//
//  MainController.swift
//  OnTheMap
//
//  Created by Martin Janák on 18/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(navigationItem)
    }
    
    func setup(_ navigationItem: UINavigationItem) {
        
        let logoutButton = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logout)
        )
        
        let pinButton = UIBarButtonItem(
            image: #imageLiteral(resourceName: "icon_pin"),
            style: .plain,
            target: self,
            action: #selector(post)
        )
        
        let refershButton = UIBarButtonItem(
            image: #imageLiteral(resourceName: "icon_refresh"),
            style: .plain,
            target: self,
            action: #selector(refresh)
        )
        
        navigationItem.title = "On The Map"
        navigationItem.rightBarButtonItems = [refershButton, pinButton]
        navigationItem.leftBarButtonItems = [logoutButton]
    }
    
    func logout() {
        Loader.show(controller: self)
        UdacityClient.shared.deleteSession() { _ in
            Loader.hide() {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func post() {
        let postController = PostController()
        present(postController, animated: true, completion: nil)
    }
    
    func refresh() {
        // to be overriden
    }
    
}
