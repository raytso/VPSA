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
    func releaseCapturedImages()
}

protocol ConfirmPopoverViewControllerDelegate: class {
    func userFinishedSelecting()
}

class ConfirmPopoverViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties

    var filesToUpload: [UploadFile]? = []
    
    var cameraFeed: CameraFeed?
    
    var imageCellCenterInset: CGFloat {
        return (imageCollectionView.bounds.width - 300.0) / 2
    }
    
    weak var delegate: ConfirmPopoverViewControllerDelegate?
    
    var blurEffectView: UIVisualEffectView?
    
    var blurEffect: UIBlurEffect?
    
    private var selectedUIImageSets: [UIImage] = []
    
    private var capturedImageDataSets: [Data]? {
        didSet {
            guard capturedImageDataSets != nil else { return }
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
    
    // MARK: - Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var imageCollectionView: UICollectionView! {
        didSet {
            self.imageCollectionView.delegate = self
            self.imageCollectionView.dataSource = self
        }
    }
    
    // MARK: Actions
    
    @IBAction func returnToCamera(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifiers.BackToCamera, sender: nil)
    }
    
    // MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ConfirmPictureImageSelectionCollecterViewCell
        cell.image = capturedImageUIImageSets?[indexPath.item]
        if (userSelectedIndecies![indexPath.item]) {
            cell.checkMask.isHidden = false
            cell.imageSelectedMask.isHidden = true
        } else {
            cell.checkMask.isHidden = true
            cell.imageSelectedMask.isHidden = false
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
            cell.checkMask.setViewIsToHide(hidden: true)
            cell.imageSelectedMask.setViewIsToHide(hidden: false)
            userSelectedIndecies![indexPath.item] = false
        } else {
            cell.checkMask.setViewIsToHide(hidden: false)
            cell.imageSelectedMask.setViewIsToHide(hidden: true)
            userSelectedIndecies![indexPath.item] = true
        }
    }
    
    // MARK: - UDFs
    private func updateUI() {
        self.imageCollectionView.reloadData()
    }
    
    private func creatingFilesToUpload() {
        for state in userSelectedIndecies!.enumerated() {
            guard state.element else { continue }
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
            guard !selectState else { return false }
        }
        return true
    }
    
    private func backgroundBlur(effect: UIBlurEffect) {
        blurEffectView?.effect = effect
    }

    
    // MARK: - Application Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Blur Effect
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor.clear
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView?.frame = self.view.bounds
            blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.insertSubview(blurEffectView!, at: 0)
        } else {
            self.view.backgroundColor = UIColor.black
        }
        
        capturedImageDataSets = cameraFeed?.getCapturedImageDataSets(sender: self)
        imageCollectionView.contentInset = UIEdgeInsetsMake(-20.0, 0.0, 0.0, 0.0)
        self.automaticallyAdjustsScrollViewInsets = false
        self.imageCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        // Navigation bar
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        navBar.backgroundColor = UIColor.clear
//        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        filesToUpload = []
        let effect = UIBlurEffect(style: .dark)
        UIView.animate(withDuration: 0.5) {
            self.backgroundBlur(effect: effect)
        }
        updateUI()
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
        
        if segue.identifier == SegueIdentifiers.SubmitView {
            if let controller = segue.destination as? SubmitViewController {
                controller.filesToUpload = filesToUpload
                controller.convertedSelectedImages = selectedUIImageSets
                cameraFeed?.releaseCapturedImages()
                delegate?.userFinishedSelecting()
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



















