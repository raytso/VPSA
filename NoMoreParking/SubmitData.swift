//
//  Submit.swift
//  NoMoreParking
//
//  Created by Ray Tso on 11/28/16.
//  Copyright © 2016 Ray Tso. All rights reserved.
//

//import Foundation
//
//class SubmitData {
//    // MARK: - Data
//    private var submitAddress: String?
//    private var submitTime: Date?
//    private var submitLocation: String?
//    private var submitPhotos: [CGImage?]?
//    private var submitCarPlateNumber: String?
//    private var submitDescription: Int?
//    private var script: String! = nil
//    private var allConditionsSet: Bool
//    private var ownerEmail: String?
//    
//    struct OwnerData {
//        static let name = "臺北市政府"
//        static let address = "臺北市信義區市府路1號"
//        static let phoneNumber = "(02)2720-8889"
//    }
//    
//    // MARK: - Initializer
//    
//    init(address    : String?,
//         time       : Date?,
//         location   : String?,
//         photos     : [CGImage?]?,
//         plateNo    : String?,
//         description: Int?) {
//        self.submitAddress = address
//        self.submitTime = time
//        self.submitLocation = location
//        self.submitPhotos = photos
//        self.submitCarPlateNumber = plateNo
//        self.submitDescription = description
//        self.allConditionsSet = false
//    }
//    
//    // MARK: - Script Functions
//    
//    func createScript() {
//        // Pass arguments to js script
//        
//        // Generating run script
//        
//    }
//    
//    func runScript() {
//        if allConditionsSet {
//            // Run script
//            let context = JSContext()
//            let _ = context?.evaluateScript(script!)
//        } else {
//            // Alert
//            debugPrint("Conditions not set")
//        }
//    }
//}
