//
//  UserInfoInputTableViewCell.swift
//  NoMoreParking
//
//  Created by Ray Tso on 3/9/17.
//  Copyright © 2017 Ray Tso. All rights reserved.
//

import UIKit

class UserInfoInputTableViewCell: UITableViewCell {
    
    var userInfo: UserInformation? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var title: UILabel!
    
    
    private func updateUI() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
