//
//  SubmitViewViewController.swift
//  NoMoreParking
//
//  Created by Ray Tso on 9/19/16.
//  Copyright © 2016 Ray Tso. All rights reserved.
//
//
//import UIKit
//
//class SubmitViewViewController: UIViewController, ViolationFormMetadataDataSource, UITextFieldDelegate {
//    
//    // MARK: - VFDSProtocol
//    func filesToUploadForViolationForm(sender: ViolationForm) -> [UploadFile]? {
//        return filesToUpload
//    }
//    
//    // MARK: - Outlets and Actions
//    
//    @IBOutlet weak var timeLabel: UILabel! {
//        didSet {
//            time = Time(data: filesToUpload?[0].content)
//            if let dateString = time?.getFullDate() {
//                if let timeString = time?.getFullTime() {
//                    timeLabel.text = dateString + "" + timeString
//                }
//            }
//        }
//    }
//    
//    @IBOutlet weak var submitButton: UIButton!
//    @IBAction func submitButton(_ sender: Any) {
////        createForm()
//        submitButtonPushed()
//    }
//    
//    @IBOutlet weak var inputCarPlateNumber: UITextField!
//    @IBOutlet weak var violationLocationTextField: UITextField! {
//        didSet {
//            targetAddress = Address()
//            AppDelegate.gpsInstance?.address = targetAddress
//        }
//    }
//    @IBOutlet weak var gpsSignalWeakWarning: UILabel!
////        checkWeakSignalWarning()
//    
//    @IBAction func inputCarPlateNumberTouchAction(_ sender: Any) {
//        
//    }
//    
//    
//    // MARK: - Variables
//    var filesToUpload: [UploadFile]?
//    private var form: ViolationForm? {
//        didSet {
//            form?.dataSource = self
//        }
//    }
//    private var targetCarPlateNumber: String? //user input
//    private var time: Time? // get
//    private var targetAddress: Address? // user input or gps
//    private var weakSignal: Bool = true
////    private var addressDetails: String? // user input or gps
//    
//    //UITextFieldDelegate
//    
//    
//    
//    
//    // MARK: - UDFs
//    private func checkGPSStrength() {
//        
//    }
//    
//    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
//        self.view.endEditing(true)
//    }
//    
//    private func checkWeakSignalWarning() {
//        if AppDelegate.gpsInstance?.signalStrength == GPSSignalStrength.Low {
//            weakSignal = true
////            gpsSignalWeakWarning.text = "GPS訊號太過微弱，無法抓取準確地址"
////            gpsSignalWeakWarning.isHidden = false
//        }
//        else {
//            weakSignal = false
////            gpsSignalWeakWarning.text = nil
////            gpsSignalWeakWarning.isHidden = true
//        }
//    }
//    
//    private func submitButtonPushed() {
//        let req = FormSessionRequest()
//        // wheel start
//        req.post(formToSubmit: form!)
//        // finished animation
//    }
//    
////    private func createForm() {
////        
////        form = ViolationForm(desiredPrivacy: .Default,
////                             carPlate: targetCarPlateNumber,
////                             violationTime: time,
////                             violationAddress: targetAddress, violationType: )
////    }
//   
////    private func UploadFile() {
////        guard userSelectedFiles != nil else {
////            return
////        }
//////        for file in userSelectedFiles! {
//////            switch mediaTypeOfFile(file: file) {
//////            case UploadFileTypes.Image:
//////                targetFile.fileType = UploadFileTypes.Image
//////            case UploadFileTypes.Video:
//////                targetFile.fileType = UploadFileTypes.Video
//////            default:
//////                targetFile.fileType = UploadFileTypes.GhostFile
//////            }
//////            targetFile.contents?.append(file)
//////        }
////        targetFile.contents = userSelectedFiles
////        filesToUpload?.append(targetFile)
////    }
//    
//    // MARK: - View cycles
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
//        self.view.addGestureRecognizer(tap)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
////        violationLocationTextField.text = targetAddress?.getFullAddress()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.backgroundColor = UIColor.red
//        navigationController?.navigationBar.isTranslucent = true
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.checkWeakSignalWarning()
//            if self.weakSignal {
//                DispatchQueue.main.async {
//                    self.gpsSignalWeakWarning.text = "GPS訊號太過微弱，無法抓取準確地址"
//                }
//            }
//            else {
//                DispatchQueue.main.async {
//                    self.gpsSignalWeakWarning.text = nil
//                }
//            }
//            var sscache: GPSSignalStrength?
//            repeat {
////                checkGPSStrength()
//                sscache = AppDelegate.gpsInstance?.signalStrength
//                guard sscache != nil && sscache != GPSSignalStrength.Low else { continue }
//                DispatchQueue.main.async {
//                    guard !self.violationLocationTextField.isEditing else { return }
//                    self.violationLocationTextField.text = self.targetAddress?.getFullAddress()
//                }
//                if AppDelegate.gpsInstance!.isGPSRunning {
//                    AppDelegate.gpsInstance!.stopGPS()
//                }
//            } while (sscache == GPSSignalStrength.Low || sscache == nil)
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
