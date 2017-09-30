//
//  GradientView.swift
//  OnTheMap
//
//  Created by Martin Janák on 17/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    public var startColor: UIColor = UIColor.clear {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    
    public var endColor: UIColor = UIColor.clear {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            setNeedsDisplay()
        }
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = bounds
    }
}
