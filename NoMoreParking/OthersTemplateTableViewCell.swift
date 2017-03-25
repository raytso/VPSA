//
//  OthersTemplateTableViewCell.swift
//  NoMoreParking
//
//  Created by Ray Tso on 3/6/17.
//  Copyright © 2017 Ray Tso. All rights reserved.
//

import UIKit

class OthersTemplateTableViewCell: UITableViewCell {
    
    var thumbnailImage: UIImage?
    var dataText: String?
    private static let pullDownIcon: UIImage = #imageLiteral(resourceName: "Cancel")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
