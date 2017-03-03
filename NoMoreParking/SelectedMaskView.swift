//
//  ImageDidSelectMask.swift
//  NoMoreParking
//
//  Created by Ray Tso on 3/1/17.
//  Copyright © 2017 Ray Tso. All rights reserved.
//

import UIKit

class SelectedMaskView: UIView {
    
    var contentView: UIView?
    
    @IBOutlet weak var checkIconImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setViewIsToHide(hidden: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SelectedMaskView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    private func setupView() {
        contentView = loadViewFromXib()
        contentView!.frame = bounds
        contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(contentView!)
    }
    
    func setViewIsToHide(hidden: Bool) {
        UIView.transition(with: self, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        }) { (_) in }
    }
    
//    func hideMask() {
//        self.isHidden = true
////        checkIconImageView.isHidden = true
////        backgroundView.isHidden = true
//    }
//    
//    func showMask() {
//        self.isHidden = false
////        checkIconImageView.isHidden = false
////        backgroundView.isHidden = false
//    }
    
//    override func updateConstraints() {
//        super.updateConstraints()
//        addConstraint(NSLayoutConstraint(item: self,
//                                         attribute: .height,
//                                         relatedBy: .equal,
//                                         toItem: nil,
//                                         attribute: .notAnAttribute,
//                                         multiplier: 1.0,
//                                         constant: 408.0))
//        addConstraint(NSLayoutConstraint(item: self,
//                                         attribute: .width,
//                                         relatedBy: .equal,
//                                         toItem: nil,
//                                         attribute: .notAnAttribute,
//                                         multiplier: 1.0,
//                                         constant: 240.0))
//        
//        addConstraint(NSLayoutConstraint(item: contentView,
//                                         attribute: .top,
//                                         relatedBy: .equal,
//                                         toItem: self,
//                                         attribute: .top,
//                                         multiplier: 1.0,
//                                         constant: 0.0))
//        addConstraint(NSLayoutConstraint(item: contentView,
//                                         attribute: .bottom,
//                                         relatedBy: .equal,
//                                         toItem: self,
//                                         attribute: .bottom,
//                                         multiplier: 1.0,
//                                         constant: 0.0))
//        addConstraint(NSLayoutConstraint(item: contentView,
//                                         attribute: .trailing,
//                                         relatedBy: .equal,
//                                         toItem: self,
//                                         attribute: .trailing,
//                                         multiplier: 1.0,
//                                         constant: 0.0))
//        addConstraint(NSLayoutConstraint(item: contentView,
//                                         attribute: .leading,
//                                         relatedBy: .equal,
//                                         toItem: self,
//                                         attribute: .leading,
//                                         multiplier: 1.0,
//                                         constant: 0.0))
//    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
