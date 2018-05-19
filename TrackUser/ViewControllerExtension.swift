//
//  ViewControllerExtension.swift
//  TrackUser
//
//  Created by Dhruv  on 5/19/18.
//  Copyright © 2018 Dhruv . All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension ViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation.isKind(of: MKUserLocation.self)) {
            return nil
        }
        if annotation.isKind(of: UserAnnotation.self) {
            let  annotationView = UserAnnotationView.init(annotation: annotation, reuseIdentifier: "User_Annotation")
            let imgView = UIImageView()
            imgView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            imgView.image =  #imageLiteral(resourceName: "ic_arrow_red")
            let altitudeVw = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            altitudeVw.backgroundColor = UIColor.clear
            annotationView.frame =  CGRect(x: 0, y: 0, width: 30, height: 30)
            altitudeVw.addSubview(imgView)
            annotationView.addSubview(altitudeVw)
            (annotation as! UserAnnotation).annotationView = annotationView
            return annotationView
        }
        return nil
    }
    
}
