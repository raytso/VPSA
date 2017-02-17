//
//  Address.swift
//  NoMoreParking
//
//  Created by Ray Tso on 12/28/16.
//  Copyright © 2016 Ray Tso. All rights reserved.
//

import Foundation
import CoreLocation

protocol AddressClassDatasource {
    func locationDataForAddressClass(sender: Address) -> CLLocation?
}

class Address {
    private let taipeiCityDistrictDictionary: [String : String] = [ "100" : "中正區",
                                                                    "103" : "大同區",
                                                                    "104" : "中山區",
                                                                    "105" : "松山區",
                                                                    "106" : "大安區", 
                                                                    "108" : "萬華區", 
                                                                    "110" : "信義區", 
                                                                    "111" : "士林區", 
                                                                    "112" : "北投區", 
                                                                    "114" : "內湖區", 
                                                                    "115" : "南港區", 
                                                                    "116" : "文山區",]
    var city: String? {
        return placemark?.subAdministrativeArea
    }
    
    private var districtName: String? {
        return taipeiCityDistrictDictionary[districtNumber!]
    }
    
    var districtNumber: String? {
        return placemark?.postalCode
    }
    
    var street: String? {
        return placemark?.thoroughfare
    }
    
    var details: String?
    private var placemark: CLPlacemark?
    private var location: CLLocation? {
        didSet {
            reverseGeoLocation(latestLocation: location)
        }
    }
    var dataSource: AddressClassDatasource? {
        didSet {
            setDataFromGPSLocationManager()
        }
    }
    
    func getFullAddress() -> String? {
        guard (districtNumber != nil),
              (city != nil),
              (districtName != nil),
              (street != nil) else { return nil }
        
        return "\(districtNumber!)" + "\(city!)" + "\(districtName!)" + "\(street!)" + "\(details ?? "")"
    }
    
    private func setDataFromGPSLocationManager() {
        self.location = dataSource?.locationDataForAddressClass(sender: self)
    }
    
    private func reverseGeoLocation(latestLocation: CLLocation?) {
//        guard latestLocation != nil else { return nil }
        debugPrint(latestLocation?.coordinate ?? 0.87)
        CLGeocoder().reverseGeocodeLocation(latestLocation!, completionHandler: { (ppplacemarks, error) -> Void in
            if (ppplacemarks?.count)! > 0 {
                self.placemark = ppplacemarks![0]
            }
        })
    }
}
