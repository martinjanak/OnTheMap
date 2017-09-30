//
//  TabBarController.swift
//  OnTheMap
//
//  Created by Martin Janák on 30/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    private func setupViewControllers() {
    
        let mapController = MapController()
        mapController.tabBarItem = UITabBarItem(
            title: "Map",
            image: #imageLiteral(resourceName: "icon_mapview-deselected"),
            tag: 0
        )
        
        let listController = ListController()
        listController.tabBarItem = UITabBarItem(
            title: "List",
            image: #imageLiteral(resourceName: "icon_listview-deselected"),
            tag: 1
        )
        
        let viewControllerList = [mapController, listController]
        
        viewControllers = viewControllerList.map {
            UINavigationController(rootViewController: $0)
        }
        
    }
}
