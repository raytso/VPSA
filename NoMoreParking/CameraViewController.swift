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

//    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var cameraFeedView: UIView!
    
    @IBOutlet weak var captureImageButton: UIButton!
    
    @IBAction func capturePhoto(_ captureImageButton: UIButton) {
        self.capture.captureImage()
    }
    @IBAction func unwindToCameraView(segue: UIStoryboardSegue) {
        
    }
    
    @IBOutlet weak var confirmButton: UIButton!
    
//    fileprivate var capturedImageDataSets: [Data?] = []
    
    private var capture = CameraFeed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        confirmButton.isHidden = true
        capture.delegate = self
        capture.setupCameraSettings(cameraType: .BackCamera, cameraPreviewFrameSize: UIScreen.main.bounds)
        
        if let preview = capture.previewLayer {
            self.view.layer.insertSublayer(preview, below: cameraFeedView.layer)
        }
        
        // start camera?
        capture.startCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    struct SegueIdentifiers {
        static let ConfirmView = "confirmViewSegueIdentifier"
//        static let SubmitView = "submitViewSegueIdentifier"
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.ConfirmView {
            if let destinaitonController = segue.destination as? ConfirmPopoverViewController {
                destinaitonController.cameraFeed = capture
                destinaitonController.delegate = self
            }
        }
    }
}

extension CameraViewController: ConfirmPopoverViewControllerDelegate {
    func userFinishedSelecting() {
        confirmButton.isHidden = true
    }
}

extension CameraViewController: CameraFeedDelegate {
    func finishedRenderingCapture() {
        self.confirmButton.isHidden = false
        DispatchQueue.main.async {
            let shutterView = UIView(frame: UIScreen.main.bounds)
            shutterView.backgroundColor = UIColor.black
            self.cameraFeedView.addSubview(shutterView)
            UIView.animate(withDuration: 0.2, animations: {
                shutterView.alpha = 0.0
            }, completion: { (_) in
                shutterView.removeFromSuperview()
            })
        }
    }
}






