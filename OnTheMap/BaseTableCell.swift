//
//  BaseTableCell.swift
//  OnTheMap
//
//  Created by Martin Janák on 01/07/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView() {
        // override by implementations
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}
