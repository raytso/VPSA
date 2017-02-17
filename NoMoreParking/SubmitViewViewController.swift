//
//  SubmitViewViewController.swift
//  NoMoreParking
//
//  Created by Ray Tso on 9/19/16.
//  Copyright © 2016 Ray Tso. All rights reserved.
//

import UIKit

class SubmitViewViewController: UIViewController, ViolationFormMetadataDataSource, UITextFieldDelegate {
    
    // VFDSProtocol
    func filesToUploadForViolationForm(sender: ViolationForm) -> [UploadFile]? {
        return filesToUpload
    }
    
    // Outlets and Actions
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            time = Time(data: filesToUpload?[0].content)
            timeLabel.text = (time?.getFullDate())! + (time?.getFullTime())!
        }
    }
    
//    if inputCarPlateNumber.hasText {
//    targetCarPlateNumber = inputCarPlateNumber.text
//    }
    
    
    @IBAction func submitButton(_ sender: Any) {
        createForm()
        submitButtonPushed()
    }
    @IBOutlet weak var inputCarPlateNumber: UITextField!
    @IBOutlet weak var violationLocationTextField: UITextField! {
        didSet {
//            gpsTest.startGPS()
            targetAddress = Address()
            AppDelegate.gpsInstance?.address = targetAddress
//            AppDelegate.gpsInstance?.address = targetAddress
            
        }
    }
    @IBAction func inputCarPlateNumberTouchAction(_ sender: Any) {
        violationLocationTextField.text = targetAddress?.getFullAddress()
    }
    
    
    // Variables
    var filesToUpload: [UploadFile]?
//    var gpsTest = GPSManager(desiredSignalStrength: .Strong)
    private var form: ViolationForm? {
        didSet {
            form?.dataSource = self
        }
    }
    private var targetCarPlateNumber: String? //user input
    private var time: Time? // get
    private var targetAddress: Address? // user input or gps
//    private var addressDetails: String? // user input or gps
    
    //UITextFieldDelegate
    
    
    
    // UDF
    private func submitButtonPushed() {
        let req = FormSessionRequest()
        // wheel start
        req.post(formToSubmit: form!)
        // finished animation
    }
    
    private func createForm() {
        form = ViolationForm(desiredPrivacy: .Default, carPlate: targetCarPlateNumber, violationTime: time, violationAddress: targetAddress)
    }
   
//    private func UploadFile() {
//        guard userSelectedFiles != nil else {
//            return
//        }
////        for file in userSelectedFiles! {
////            switch mediaTypeOfFile(file: file) {
////            case UploadFileTypes.Image:
////                targetFile.fileType = UploadFileTypes.Image
////            case UploadFileTypes.Video:
////                targetFile.fileType = UploadFileTypes.Video
////            default:
////                targetFile.fileType = UploadFileTypes.GhostFile
////            }
////            targetFile.contents?.append(file)
////        }
//        targetFile.contents = userSelectedFiles
//        filesToUpload?.append(targetFile)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        violationLocationTextField.text = targetAddress?.getFullAddress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
