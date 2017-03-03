//
//  ConfirmPictureCollectionViewCell.swift
//  NoMoreParking
//
//  Created by Ray Tso on 2/23/17.
//  Copyright © 2017 Ray Tso. All rights reserved.
//

import UIKit

class ConfirmPictureImageSelectionCollecterViewCell: UICollectionViewCell {
    
    // MARK: - Variables
//    var imageMaskView: SelectedMaskView?
    var image: UIImage! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var capturedImageShots: UIImageView!
    @IBOutlet weak var imageSelectedMask: SelectedMaskView!
    
    // MARK: - UDFs
    private func updateUI() {
        capturedImageShots.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        backgroundView?.layer.cornerRadius = 12.0
//        backgroundView?.layer.masksToBounds = true
//        backgroundView?.layer.borderColor = UIColor.darkGray.cgColor
//        backgroundView?.layer.borderWidth = 1.0
        
//        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 12.0).cgPath
//        self.layer.shadowPath = path
        self.layer.masksToBounds = false
    }
}
