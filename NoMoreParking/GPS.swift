//
//  GPS.swift
//  NoMoreParking
//
//  Created by Ray Tso on 2/6/17.
//  Copyright © 2017 Ray Tso. All rights reserved.
//

import Foundation
import CoreLocation

class GPSManager: NSObject, CLLocationManagerDelegate, AddressClassDatasource
{
    private var locationManager: CLLocationManager = CLLocationManager()
    private var signalStrengthThreshold: GPSSignalStrength
    var isGPSRunning: Bool = false
    var signalStrength: GPSSignalStrength? {
        guard myLocation != nil else {
            return nil
        }
        if myLocation!.horizontalAccuracy.binade > 200.0 {
            return GPSSignalStrength.Low
        }
        else if myLocation!.horizontalAccuracy > 80.0 {
            return GPSSignalStrength.Moderate
        }
        else {
            return GPSSignalStrength.Strong
        }
    }
    weak var address: Address? {
        didSet {
            address?.dataSource = self
//            locationManager.requestLocation()
        }
    }
    private var myLocation: CLLocation?
    
    init(desiredSignalStrength: GPSSignalStrength) {
        // init
        self.signalStrengthThreshold = desiredSignalStrength
//        self.address = Address()
    }
    
    func startGPS() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        isGPSRunning = true
    }
    
    func stopGPS() {
        locationManager.stopUpdatingLocation()
        isGPSRunning = false
    }
    
    func refresh() {
        locationManager.requestLocation()
    }
    
    func locationDataForAddressClass(sender: Address) -> CLLocation? {
//        self.address = sender //??
        return myLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation = locations[locations.count - 1]
        debugPrint(latestLocation)
        debugPrint(latestLocation.horizontalAccuracy)
        myLocation = latestLocation
        debugPrint("GPS = \(myLocation)")
    }
}

enum GPSSignalStrength {
    case Low
    case Moderate
    case Strong
}
