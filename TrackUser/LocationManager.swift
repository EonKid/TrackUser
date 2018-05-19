//
//  LocationManager.swift
//  TrackUser
//
//  Created by Dhruv  on 5/19/18.
//  Copyright © 2018 Dhruv . All rights reserved.
//

import UIKit

import UIKit
import CoreMotion
import CoreLocation

let kUserLocationNotification = "UserLocationNotification"


class LocationManager: NSObject, CLLocationManagerDelegate , UIAlertViewDelegate {
    
    
    // MARK: - Class Variables
    var locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    var userHeading = Double()
    var isStopManagerAfterLocationUpdate = Bool()
    //Singleton
    static let shared = LocationManager()
    private override init() {}
    
    func startStandardUpdates() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.distanceFilter = 1
        // meters
        locationManager.pausesLocationUpdatesAutomatically = false
        
        if (Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") != nil) {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        userHeading = Double(newHeading.magneticHeading).degreesToRadians
        let dictUserData = NSMutableDictionary()
        dictUserData.setObject("\(currentLocation.latitude)", forKey: "lat" as NSCopying)
        dictUserData.setObject("\(currentLocation.longitude)", forKey: "longt" as NSCopying)
        dictUserData.setObject("\(userHeading)", forKey: "heading" as NSCopying)
        let uuidString = UIDevice.current.identifierForVendor?.uuidString
        dictUserData.setObject(uuidString!, forKey: "uuid" as NSCopying)
        NotificationCenter.default.post(name: Notification.Name(kUserLocationNotification), object: dictUserData)
        if isStopManagerAfterLocationUpdate{
            stopStandardUpdate()
            isStopManagerAfterLocationUpdate = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // If it's a relatively recent event, turn off updates to save power.
        let location: CLLocation = locations.last!
        let strLocation = "\(location.coordinate.latitude)"
        if strLocation != "" {
            currentLocation = location.coordinate
            let dictUserData = NSMutableDictionary()
            dictUserData.setObject("\(currentLocation.latitude)", forKey: "lat" as NSCopying)
            dictUserData.setObject("\(currentLocation.longitude)", forKey: "longt" as NSCopying)
            dictUserData.setObject("\(userHeading)", forKey: "heading" as NSCopying)
            print("Location: ",dictUserData)
            UserDefaults.standard.set("\(currentLocation.latitude)", forKey: "lat")
            UserDefaults.standard.set("\(currentLocation.longitude)", forKey: "longt")
            UserDefaults.standard.set("\(userHeading)", forKey: "heading")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(kUserLocationNotification), object: dictUserData)
            if isStopManagerAfterLocationUpdate{
                stopStandardUpdate()
                isStopManagerAfterLocationUpdate = false
            }
        }
    }
    
    func stopStandardUpdate(){
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }
    
    //MARK:- WHEN DENIED
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied {
            NSLog("DENIAL")
            UserDefaults.standard.set("\(0.0)", forKey: "lat")
            UserDefaults.standard.set("\(0.0)", forKey: "longt")
            self.generateAlertToNotifyUser()
        }
    }
    
    func generateAlertToNotifyUser() {
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined{
            var title: String
            title = ""
            let message: String = "Location Services are not able to determine your location"
            let alertView: UIAlertView = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Settings")
            alertView.show()
        }
        
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied{
            var title: String
            title = "Location services are off"
            let message: String = "To post spots or find near by spots, you must turn on Location Services from Settings"
            let alertView: UIAlertView = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Settings")
            alertView.show()
        }
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined
        {
            startStandardUpdates()
        }
    }
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 1 {
            // Send the user to the Settings for this app
            let settingsURL: URL = URL(string: UIApplicationOpenSettingsURLString)!
            UIApplication.shared.openURL(settingsURL)
        }
    }
    
}


