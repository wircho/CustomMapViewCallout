//
//  ViewController.swift
//  CustomMapView
//
//  Created by Adolfo Rodriguez on 2015-08-20.
//  Copyright (c) 2015 Relevant. All rights reserved.
//

import UIKit

import MapKit

//Omar: I removed the unnecessary "reuseIdnetifier" computer property
// from the StackOverflow answer. Instead I am just using a private global
// property here, which is perfectly acceptable.

private let reuseIdentifier = "CustomPin"

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let annotation = MKPointAnnotation()
        annotation.title = "Montreal"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 45.500810, longitude: -73.569915)
        
        
        self.mapView.addAnnotation(annotation)
        
        self.mapView.showAnnotations([annotation], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Omar: This delegate method is the one that ensures that the annotation's pin
    // is of class CustomPin. Otherwise it would have used the default MKPinAnnotationView
    // which has the default callout.
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let pin = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier) ?? CustomPin(annotation: annotation, reuseIdentifier:reuseIdentifier)!
        
        pin.canShowCallout = false
        
        return pin
    }

    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        if let mapPin = view as? CustomPin {
            updatePinPosition(mapPin)
        }
    }
    
    func mapView(mapView: MKMapView!, didDeselectAnnotationView view: MKAnnotationView!) {
        if let mapPin = view as? CustomPin {
            if mapPin.preventDeselection {
                mapView.selectAnnotation(view.annotation, animated: false)
            }
        }
    }
    
    func updatePinPosition(pin:CustomPin) {
        let defaultShift:CGFloat = 50
        let pinPosition = CGPointMake(pin.frame.midX, pin.frame.maxY)
        
        let y = pinPosition.y - defaultShift
        
        let controlPoint = CGPointMake(pinPosition.x, y)
        let controlPointCoordinate = mapView.convertPoint(controlPoint, toCoordinateFromView: mapView)
        
        mapView.setCenterCoordinate(controlPointCoordinate, animated: true)
    }
    

}

