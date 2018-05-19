//
//  UserAnnotationView.swift
//  TrackUser
//
//  Created by Dhruv  on 5/19/18.
//  Copyright © 2018 Dhruv . All rights reserved.
//


import UIKit
import MapKit
class UserAnnotationView: MKAnnotationView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.isEnabled = false
        self.isDraggable = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateHeading(_ heading: Float) {
        self.transform = CGAffineTransform.identity
        self.transform = CGAffineTransform(rotationAngle: CGFloat(heading))
    }
    
    
}
