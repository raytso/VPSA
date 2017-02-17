//
//  ConfirmPopoverViewController.swift
//  NoMoreParking
//
//  Created by Ray Tso on 9/20/16.
//  Copyright © 2016 Ray Tso. All rights reserved.
//

import UIKit

protocol CapturedImageDataSource: class {
    func getCapturedImageDataSets(sender: ConfirmPopoverViewController) -> [Data]?
}

class ConfirmPopoverViewController: UIViewController {
    
    var filesToUpload: [UploadFile]? = []
//    var address: Address?

    private var capturedImageDataSets: [Data]?
    private var capturedVideoDataSets: [Data]?
    weak var dataSource: CapturedImageDataSource?
    var cameraFeed: CameraFeed? {
        didSet {
            debugPrint("cameraFeed transfer complete")
        }
    }
    @IBOutlet weak var captureImageShot: UIImageView!
    @IBOutlet weak var returnToCamera: UIButton!
    @IBAction func prepareSubmitForm(_ sender: UIButton) {
        // call location data
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dataSource =
        // Do any additional setup after loading the view.
        
        capturedImageDataSets = cameraFeed?.getCapturedImageDataSets(sender: self) ?? []
        capturedVideoDataSets = cameraFeed?.getCapturedImageDataSets(sender: self) ?? []
        let photoRawData = capturedImageDataSets?.last
        DispatchQueue.main.async {
            self.updateImage(jpgRawData: photoRawData!)
        }
        creatingFilesToUpload()
//        let t = Time(data: capturedImageDataSets![0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateImage(jpgRawData: Data) {
        capturedImageDataSets = cameraFeed?.getCapturedImageDataSets(sender: self) ?? []
        let photo = capturedImageDataSets?.last
        if photo == nil {
            debugPrint("using default empty image")
        } else {
            debugPrint("success")
            captureImageShot.image = UIImage(data: jpgRawData)
        }
    }
    
    private func creatingFilesToUpload() {
        var indexCount = 0
        for image in capturedImageDataSets! {
            var file = UploadFile()
            file.content = image
            file.fileName = "image\(indexCount).jpg"
            file.fileType = UploadFileTypes.Image
            indexCount += 1
            filesToUpload?.append(file)
        }
        
        indexCount = 0
//        for video in capturedVideoDataSets! {
//            var file = UploadFile()
//            file.content = video
//            file.fileName = "video\(indexCount)"
//            file.fileType = UploadFileTypes.Video
//            indexCount += 1
//            filesToUpload?.append(file)
//        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == SegueIdentifiers.SubmitView {
            if let controller = segue.destination as? SubmitViewViewController {
                controller.filesToUpload = filesToUpload
            }
        }
    }



}


