//
//  CameraViewController.swift
//  NoMoreParking
//
//  Created by Ray Tso on 9/9/16.
//  Copyright © 2016 Ray Tso. All rights reserved.
//

import UIKit
import CoreLocation

class CameraViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var cameraFeedView: UIView!
    @IBOutlet weak var captureImageButton: UIButton!
    @IBAction func capturePhoto(_ captureImageButton: UIButton) {
        DispatchQueue.global().async {
//            debugPrint("Capturing image..")
            self.capture.captureImage()
            DispatchQueue.main.async {
                self.confirmButton.isHidden = false
            }
        }
    }
    @IBAction func unwindToCameraView(segue: UIStoryboardSegue){}
    @IBOutlet weak var confirmButton: UIButton!
    
    private var capturedImageDataSets: [Data?] = []
    
    private var capture = CameraFeed()
    
    // One shot function
//    private var capturedShot: UIImage? {
//        didSet {
//            performSegue(withIdentifier: SegueIdentifiers.ConfirmView, sender: self)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        confirmButton.isHidden = true
        capture.setupCameraSettings(cameraType: .BackCamera, cameraPreviewFrameSize: UIScreen.main.bounds)
        capture.startCamera()
        self.view.layer.insertSublayer(capture.previewLayer, below: cameraFeedView.layer)
        // start camera?
    }
    
    override func viewWillAppear(_ animated: Bool) {
        capture.initImageDataSets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    struct SegueIdentifiers {
        static let ConfirmView = "confirmViewSegueIdentifier"
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == SegueIdentifiers.CaptureImageSegueIdentifier {
//            
//        }
//        return true
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == SegueIdentifiers.ConfirmView {
            if let controller = segue.destination as? UINavigationController {
                if let destinaitonController = controller.topViewController as? ConfirmPopoverViewController {
                    destinaitonController.cameraFeed = capture
                    debugPrint("Segueing... hold on...")
                }
//                controller.cameraFeed = capture
//                if capturedShot != nil {
//                    controller.capturedImage = capturedShot
//                } else {
//                    debugPrint(capturedShot)
//                }
//                if capturedImageDataSets[0] != nil {
//                    controller.capturedImage = UIImage(data: capturedImageDataSets[0]!)
//                }
            }
        }
    }
}






