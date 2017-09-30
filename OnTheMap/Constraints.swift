//
//  Constraints.swift
//  OnTheMap
//
//  Created by Martin Janák on 29/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

extension UIView {
    
    func constrainContainer(_ view: UIView, lead: CGFloat?, trail: CGFloat?, top: CGFloat?, bottom: CGFloat?) {
        
        if let lead = lead {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: lead))
        }
        
        if let trail = trail {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: trail))
        }
        
        if let top = top {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: top))
        }
        
        if let bottom = bottom {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: bottom))
        }
    }
    
    func constrainLead(_ view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: constant)
        
        self.addConstraint(constraint)
        
        return constraint
    }
    
    func constrainTrail(_ view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: constant)
        
        self.addConstraint(constraint)
        
        return constraint
    }
    
    func constrainTop(_ view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: constant)
        
        self.addConstraint(constraint)
        
        return constraint
    }
    
    func constrainBottom(_ view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: constant)
        
        self.addConstraint(constraint)
        
        return constraint
    }
    
    func constrainVertical(from: UIView, to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: from, attribute: .top, relatedBy: .equal, toItem: to, attribute: .bottom, multiplier: 1.0, constant: constant)
        
        self.addConstraint(constraint)
        
        return constraint
    }
    
    func constrainHorizontal(from: UIView, to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: from, attribute: .leading, relatedBy: .equal, toItem: to, attribute: .trailing, multiplier: 1.0, constant: constant)
        
        self.addConstraint(constraint)
        
        return constraint
    }
    
    func constrainAlign(_ view: UIView, to: UIView, left: CGFloat?, right: CGFloat?) {
        
        if let left = left {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: to, attribute: .leading, multiplier: 1.0, constant: left))
        }
        
        if let right = right {
           self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: to, attribute: .trailing, multiplier: 1.0, constant: right))
        }
    }
    
    func constrainCenter(_ view: UIView, horizontal: CGFloat?, vertical: CGFloat?) {
        
        if let horizontal = horizontal {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: horizontal))
        }
        
        if let vertical = vertical {
            self.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: vertical))
        }
    }
    
    func constrainSize(width: CGFloat?, height: CGFloat?) {
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func constrainTopLayoutGuide(controller: UIViewController, constant: CGFloat) {
        
        controller.view.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: controller.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: constant))
    }
    
}
