//
//  PinCell.swift
//  OnTheMap
//
//  Created by Martin Janák on 18/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

class PinCell: BaseTableCell {
    
    lazy var pinImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "icon_pin")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var pinLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    var label: String = "Label" {
        didSet {
            pinLabel.text = label
        }
    }
    
    override func setupView() {
        super.setupView()
        
        add(pinImageView)
        add(pinLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        pinImageView.constrainSize(width: 24, height: 24)
        self.constrainCenter(pinImageView, horizontal: nil, vertical: 0)
        _ = self.constrainLead(pinImageView, constant: 14)
        
        self.constrainCenter(pinLabel, horizontal: nil, vertical: 0)
        _ = self.constrainHorizontal(from: pinLabel, to: pinImageView, constant: 12)
    }

}
