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

protocol ConfirmPopoverViewControllerDelegate: class {
    func userFinishedSelecting(selectedFiles: [UploadFile], selectedFilesInUIImage: [UIImage])
}

class ConfirmPopoverViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties
    // MARK: Public
    var filesToUpload: [UploadFile]? = []
    weak var delegate: ConfirmPopoverViewControllerDelegate?
    var cameraFeed: CameraFeed? {
        didSet {
            debugPrint("cameraFeed transfer complete")
        }
    }
    
    // MARK: Private
    private var selectedUIImageSets: [UIImage] = []
    private var capturedImageDataSets: [Data]? {
        didSet {
            guard capturedImageDataSets != nil else {
                fatalError("CapturedImageData is nil")
            }
            for imageData in capturedImageDataSets! {
                capturedImageUIImageSets!.append(UIImage(data: imageData)!)
            }
        }
    }
    private var capturedImageUIImageSets: [UIImage]? = [] {
        didSet {
            guard !capturedImageDataSets!.isEmpty else { return }
            userSelectedIndecies = Array(repeating: true, count: capturedImageDataSets!.count)
        }
    }
    private var userSelectedIndecies: [Bool]?
    var imageCellCenterInset: CGFloat {
        return (imageCollectionView.bounds.width - 300.0) / 2
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var imageCollectionView: UICollectionView! {
        didSet {
            self.imageCollectionView.delegate = self
            self.imageCollectionView.dataSource = self
        }
    }
    
    // MARK: Actions
    
    @IBAction func returnToCamera(_ sender: Any) {
        if checkShouldPerformSegue() {
            performSegue(withIdentifier: SegueIdentifiers.BackToCamera, sender: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ConfirmPictureImageSelectionCollecterViewCell
        cell.image = capturedImageUIImageSets?[indexPath.item]
        if (userSelectedIndecies![indexPath.item]) {
            cell.imageSelectedMask.isHidden = false
        } else {
            cell.imageSelectedMask.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return capturedImageDataSets?.count ?? 0
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ConfirmPictureImageSelectionCollecterViewCell
        if (userSelectedIndecies![indexPath.item]) {
            cell.imageSelectedMask.setViewIsToHide(hidden: true)
            userSelectedIndecies![indexPath.item] = false
        } else {
            cell.imageSelectedMask.setViewIsToHide(hidden: false)
            userSelectedIndecies![indexPath.item] = true
        }
    }
    
    // MARK: - UDF
    private func updateUI() {
        debugPrint("updating UI")
        self.imageCollectionView.reloadData()
    }
    
    private func creatingFilesToUpload() {
        for state in userSelectedIndecies!.enumerated() {
            guard state.element else {
                continue
            }
            var file = UploadFile()
            file.content = capturedImageDataSets![state.offset]
            file.fileName = "image\(state.offset).jpg"
            file.fileType = UploadFileTypes.Image
            filesToUpload?.append(file)
            selectedUIImageSets.append(capturedImageUIImageSets![state.offset])
        }
    }
    
    private func checkShouldPerformSegue() -> Bool {
        if userDidNotSelectAny() {
            return false
        } else {
            creatingFilesToUpload()
            return true
        }
    }
    
    private func userDidNotSelectAny() -> Bool {
        for selectState in userSelectedIndecies! {
            guard !selectState else {
                return false
            }
        }
        return true
    }
    
    // MARK: - Application Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        capturedImageDataSets = cameraFeed?.getCapturedImageDataSets(sender: self) ?? nil
        imageCollectionView.contentInset = UIEdgeInsetsMake(-20.0, 0.0, 0.0, 0.0)
        self.automaticallyAdjustsScrollViewInsets = false
        self.imageCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        // Blur Effect
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //Fill view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.view.insertSubview(blurEffectView, at: 0)
        } else {
            self.view.backgroundColor = UIColor.black
        }
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        filesToUpload = []
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    struct SegueIdentifiers {
        static let SubmitView = "submitViewSegueIdentifier"
        static let BackToCamera = "unwindToCamera"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == SegueIdentifiers.BackToCamera {
            delegate?.userFinishedSelecting(selectedFiles: filesToUpload!, selectedFilesInUIImage: selectedUIImageSets)
            self.dismiss(animated: true, completion: nil)
        }
        else if segue.identifier == SegueIdentifiers.SubmitView {
            if let controller = segue.destination as? SubmitViewController {
                controller.filesToUpload = filesToUpload
                controller.convertedSelectedImages = selectedUIImageSets
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == SegueIdentifiers.SubmitView {
            return checkShouldPerformSegue() ? true : false
        } else {
            return true
        }
    }
    
    
}



















