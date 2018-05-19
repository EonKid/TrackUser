//
//  ViewController.swift
//  TrackUser
//
//  Created by Dhruv  on 5/19/18.
//  Copyright © 2018 Dhruv . All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var userAnnotation:UserAnnotation?
    
    @IBOutlet weak var mapVw: MKMapView!


    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    
    @IBAction func btnActionFocus(_ sender: Any) {
        focusOnLocation()
    }
    func initialSetup() {
         self.navigationItem.title = "Track User"
        self.mapVw.mapType = .hybrid
        self.mapVw.isRotateEnabled = false
        self.mapVw.delegate = self
        self.mapVw.userTrackingMode = .followWithHeading
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.onLocationChanged(notification:)) , name: NSNotification.Name(rawValue: kUserLocationNotification), object: nil)
        LocationManager.shared.isStopManagerAfterLocationUpdate = false
        LocationManager.shared.startStandardUpdates()
        focusOnLocation()
    }
    
    func focusOnLocation() {
        if UserDefaults.standard.object(forKey: "lat") != nil && UserDefaults.standard.object(forKey: "longt") != nil{
            let lat =  UserDefaults.standard.object(forKey: "lat") as! String
            let long = UserDefaults.standard.object(forKey: "longt") as! String
            var userLoc = CLLocationCoordinate2D()
            userLoc.latitude = CDouble(lat)!
            userLoc.longitude = CDouble(long)!
            let span = MKCoordinateSpanMake(0.025, 0.025)
            let region = MKCoordinateRegion(center: userLoc, span: span)
            mapVw.setRegion(region, animated: true)
            mapVw.showsUserLocation = false
        }
    }
    
    func moveToCurrentLocationOfUser(dictData:NSMutableDictionary){
        if dictData.object(forKey: "lat") != nil && dictData.object(forKey: "longt") != nil{
            let lat =  dictData.object(forKey: "lat") as! String
            let long = dictData.object(forKey: "longt") as! String
            var userLoc = CLLocationCoordinate2D()
            userLoc.latitude = CDouble(lat)!
            userLoc.longitude = CDouble(long)!
            let heading = Float(dictData.object(forKey: "heading") as! String)
            if userAnnotation == nil{
                userAnnotation = UserAnnotation.init(coordiante: userLoc, title: "user")
                userAnnotation?.setNewCoordinate(userLoc)
                self.mapVw.addAnnotation(userAnnotation!)
                userAnnotation?.setNewCoordinate(userLoc)
            }else{
                UIView.animate(withDuration: 0.2, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.userAnnotation?.setNewCoordinate(userLoc )
                }, completion: { (true) in
                    self.userAnnotation?.updateHeading(heading!)
                })
            }
        
        }
    }
    
    @objc func onLocationChanged(notification:NSNotification) {
        if let dictLocation = notification.object as? NSMutableDictionary{
            print("Received information: \(dictLocation)")
            moveToCurrentLocationOfUser(dictData: dictLocation)
        }
    }

}

