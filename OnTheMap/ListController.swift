//
//  TableController.swift
//  OnTheMap
//
//  Created by Martin Janák on 17/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit
import MapKit

class ListController: MainController {
    
    let cellId = "cellId"
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PinCell.self, forCellReuseIdentifier: cellId)
        
        view.add(tableView)
        
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    private func setupConstraints() {
        view.constrainContainer(tableView, lead: 0, trail: 0, top: 0, bottom: 0)
    }
    
    override func refresh() {
        super.refresh()
        ModelCache.shared.loadStudentLocations() { success in
            if success {
                self.tableView.reloadData()
            } else {
                Alert.notify(
                    title: "Student locations error",
                    message: "Was unnable to load student locations.",
                    controller: self
                )
            }
        }
    }
}

extension ListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelCache.shared.studentLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pinCell = tableView.dequeueReusableCell(withIdentifier: cellId) as! PinCell
        let studentLocation = ModelCache.shared.studentLocations[(indexPath as NSIndexPath).row]
        
        pinCell.label = "\(studentLocation.firstName) \(studentLocation.lastName)"
        
        return pinCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let studentLocation = ModelCache.shared.studentLocations[(indexPath as NSIndexPath).row]
        let app = UIApplication.shared
        if let url = URL(string: studentLocation.mediaUrl) {
            app.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
