//
//  AnnotationModal.swift
//  TrackUser
//
//  Created by Dhruv  on 5/19/18.
//  Copyright © 2018 Dhruv . All rights reserved.
//
import UIKit
import CoreLocation
import MapKit

class UserAnnotation: NSObject  , MKAnnotation{
    dynamic var coordinate = CLLocationCoordinate2D()
    var annotationView: UserAnnotationView?
    var title : String?
    init(coordiante coordinate: CLLocationCoordinate2D,title: NSString) {
        self.coordinate = coordinate
        self.title = title as String
    }
    
    func setNewCoordinate(_ newCoordinate: CLLocationCoordinate2D) {
        self.coordinate = newCoordinate
    }
    
    func updateHeading(_ heading: Float) {
        if (self.annotationView != nil) {
            self.annotationView?.updateHeading(heading)
        }
    }
    
}
