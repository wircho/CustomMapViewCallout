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
        let calloutViewAdded = calloutView?.superview != nil
        
        
        if (selected || !selected && hitOutside) {
            super.setSelected(selected, animated: animated)
        }
        
        self.superview?.bringSubviewToFront(self)
        
        
        //Omar: The Stack Overflow answer simply writes calloutView = CalloutView
        // here. That means it creates an empty view, which is why you don't see anything.
        // Instead I am loading the view from the nib file Callout.xib,
        // And I am setting a label's text using the annotation's title.
        // Here you could also set images, buttons, etc, as long ad they are
        // in your nib file.
        
        if (calloutView == nil) {
            calloutView = NSBundle.mainBundle().loadNibNamed("Callout", owner: nil, options: nil)[0] as? CustomCallout
            
            calloutView?.titleLabel.text = self.annotation?.title
        }
        
        if (self.selected && !calloutViewAdded) {
            addSubview(calloutView!)
            calloutView!.center = CGPointMake(10, -calloutView!.frame.size.height / 2.0)
        }
        
        if (!self.selected) {
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