//
//  CustomCallout.swift
//  CustomMapView
//
//  Created by Adolfo Rodriguez on 2015-08-20.
//  Copyright (c) 2015 Relevant. All rights reserved.
//

import Foundation

import MapKit

class CustomCallout: UIView {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func hitTest(var point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let viewPoint = superview?.convertPoint(point, toView: self) ?? point
        
        let isInsideView = pointInside(viewPoint, withEvent: event)
        
        var view = super.hitTest(viewPoint, withEvent: event)
        
        return view
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return CGRectContainsPoint(bounds, point)
    }
}
