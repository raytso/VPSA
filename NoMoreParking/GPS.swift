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
    }
    
    func stopGPS() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationDataForAddressClass(sender: Address) -> CLLocation? {
//        self.address = sender //??
        return myLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation = locations[locations.count - 1]
        debugPrint(latestLocation)
        debugPrint(latestLocation.horizontalAccuracy)
//        guard latestLocation.horizontalAccuracy <= 100.0 else {
////            locationManager.allowDeferredLocationUpdates(untilTraveled: CLLocationDistanceMax, timeout: 3.0)
//            return
//        }
//        let lat: CLLocationDegrees = 24.964319
//        let lng: CLLocationDegrees = 121.190655
//        latestLocation = CLLocation.init(latitude: lat, longitude: lng)
        myLocation = latestLocation
        debugPrint("GPS = \(myLocation)")
    }
}

enum GPSSignalStrength {
    case Low
    case Moderate
    case Strong
}
