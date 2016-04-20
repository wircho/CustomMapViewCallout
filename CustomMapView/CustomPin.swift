//
//  CustomPin.swift
//  CustomMapView
//
//  Created by Adolfo Rodriguez on 2015-08-20.
//  Copyright (c) 2015 Relevant. All rights reserved.
//

import Foundation

import MapKit

class CustomPin: MKPinAnnotationView {
    
    private var calloutView:CustomCallout?
    private var hitOutside:Bool = true
    
    var preventDeselection:Bool {
        return !hitOutside
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        if (selected) {
            super.setSelected(selected, animated: animated)
            self.superview?.bringSubviewToFront(self)
            if (calloutView == nil) {
                calloutView = NSBundle.mainBundle().loadNibNamed("Callout", owner: nil, options: nil)[0] as? CustomCallout
                
                calloutView?.titleLabel.text = self.annotation?.title
            }
            addSubview(calloutView!)
            calloutView!.center = CGPointMake(10, -calloutView!.frame.size.height / 2.0)
        } else {
            calloutView?.removeFromSuperview()
        }
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        var hitView = super.hitTest(point, withEvent: event)
        
        if let callout = calloutView {
            if (hitView == nil && self.selected) {
                hitView = callout.hitTest(point, withEvent: event)
            }
        }
        
        hitOutside = hitView == nil
        
        return hitView;
    }
}
