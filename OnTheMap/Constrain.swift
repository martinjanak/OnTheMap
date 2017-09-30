//
//  Constrain.swift
//  OnTheMap
//
//  Created by Martin Janák on 29/06/2017.
//  Copyright © 2017 Martin Janák. All rights reserved.
//

import UIKit

class Constrain {
    
    static func container(child: UIView, parent: UIView, lead: CGFloat?, trail: CGFloat?, top: CGFloat?, bottom: CGFloat?) {
        
        if let lead = lead {
            parent.addConstraint(NSLayoutConstraint(item: child, attribute: .leading, relatedBy: .equal, toItem: parent, attribute: .leading, multiplier: 1.0, constant: lead))
        }
        
        if let trail = trail {
            parent.addConstraint(NSLayoutConstraint(item: child, attribute: .trailing, relatedBy: .equal, toItem: parent, attribute: .trailing, multiplier: 1.0, constant: trail))
        }
        
        if let top = top {
            parent.addConstraint(NSLayoutConstraint(item: child, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1.0, constant: top))
        }
        
        if let bottom = bottom {
            parent.addConstraint(NSLayoutConstraint(item: child, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1.0, constant: bottom))
        }
    }
    
    static func lead(_ value: CGFloat, child: UIView, parent: UIView) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: child, attribute: .leading, relatedBy: .equal, toItem: parent, attribute: .leading, multiplier: 1.0, constant: value)
        
        parent.addConstraint(constraint)
        
        return constraint
    }
    
    static func trail(_ value: CGFloat, child: UIView, parent: UIView) -> NSLayoutConstraint {
        
        let tconstraint = NSLayoutConstraint(item: child, attribute: .trailing, relatedBy: .equal, toItem: parent, attribute: .trailing, multiplier: 1.0, constant: value)
        
        parent.addConstraint(tconstraint)
        
        return tconstraint
    }
    
    static func top(_ value: CGFloat, child: UIView, parent: UIView) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: child, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1.0, constant: value)
        
        parent.addConstraint(constraint)
        
        return constraint
    }
    
    static func vertical(from: UIView, to: UIView, parent: UIView, value: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: from, attribute: .top, relatedBy: .equal, toItem: to, attribute: .bottom, multiplier: 1.0, constant: value)
        
        parent.addConstraint(constraint)
        
        return constraint
    }
    
    static func horizontal(from: UIView, to: UIView, parent: UIView, value: CGFloat) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: from, attribute: .leading, relatedBy: .equal, toItem: to, attribute: .trailing, multiplier: 1.0, constant: value)
        
        parent.addConstraint(constraint)
        
        return constraint
    }
    
    static func bottom(_ value: CGFloat, child: UIView, parent: UIView) {
        
        parent.addConstraint(NSLayoutConstraint(item: child, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1.0, constant: value))
    }
    
    static func center(child: UIView, parent: UIView, horizontal: Bool, vertical: Bool) {
        
        if horizontal {
            parent.addConstraint(NSLayoutConstraint(item: child, attribute: .centerX, relatedBy: .equal, toItem: parent, attribute: .centerX, multiplier: 1, constant: 0))
        }
        
        if vertical {
            parent.addConstraint(NSLayoutConstraint(item: child, attribute: .centerY, relatedBy: .equal, toItem: parent, attribute: .centerY, multiplier: 1, constant: 0))
        }
    }
    
    static func center(child: UIView, parent: UIView, horizontal: CGFloat?, vertical: CGFloat?) {
        
        if let horizontal = horizontal {
            parent.addConstraint(NSLayoutConstraint(item: child, attribute: .centerX, relatedBy: .equal, toItem: parent, attribute: .centerX, multiplier: 1, constant: horizontal))
        }
        
        if let vertical = vertical {
            parent.addConstraint(NSLayoutConstraint(item: child, attribute: .centerY, relatedBy: .equal, toItem: parent, attribute: .centerY, multiplier: 1, constant: vertical))
        }
    }
    
    static func size(view: UIView, width: CGFloat?, height: CGFloat?) {
        
        if let width = width {
            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    static func topLayoutGuide(child: UIView, controller: UIViewController, top: CGFloat) {
        
        controller.view.addConstraint(NSLayoutConstraint(item: child, attribute: .top, relatedBy: .equal, toItem: controller.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: top))
    }
    
}
