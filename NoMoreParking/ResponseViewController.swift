//
//  ResponseViewController.swift
//  NoMoreParking
//
//  Created by Ray Tso on 3/20/17.
//  Copyright © 2017 Ray Tso. All rights reserved.
//

import UIKit

protocol ResponseViewControllerDelegate: class {
    func userForcedExit(state: ResponseViewState)
}

class ResponseViewController: UIViewController {
    
    @IBOutlet weak var responseView: ResponseView!
    
    var state: ResponseViewState = .Waiting {
        didSet {
            if state != .Waiting {
                responseView.cancelButton.isHidden = false
//                responseView.hideButton(toHide: false)
            }
            if state != .Waiting {
                responseView.spinningIndicator.stopAnimating()
            }
            updateView(forView: responseView!)
            
        }
    }
    
    weak var delegate: ResponseViewControllerDelegate?
    
//    private var responseView: ResponseView?

    private func updateView(forView: UIView) {
        switch forView {
        case responseView:
            responseView.updateView(text: self.state.text, detailsText: self.state.detailsText, image: self.state.image)
        default: break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        responseView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Hide cancel button
        super.viewWillAppear(animated)
        let effect = UIBlurEffect(style: .dark)
        UIView.animate(withDuration: 0.5) { 
            self.responseView.backgroundBlur(effect: effect)
        }
        responseView.updateView(text: state.text,detailsText: state.detailsText, image: state.image)
    }
    
}

extension ResponseViewController: ResponseViewDelegate {
//    internal func finishDisplayingSuccessResponse() {
//        self.delegate?.normalExit()
//        self.dismiss(animated: true, completion: nil)
//    }
    
    internal func userDismissedView() {
        // do sth
        self.delegate?.userForcedExit(state: state)
        self.dismiss(animated: true, completion: nil)
    }
}
