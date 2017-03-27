//
//  HistoryViewTableViewCell.swift
//  NoMoreParking
//
//  Created by Ray Tso on 3/24/17.
//  Copyright © 2017 Ray Tso. All rights reserved.
//

import UIKit

class HistoryViewTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var carplateNumber: UILabel!
    
    @IBOutlet weak var caseID: UILabel!
    
    @IBOutlet weak var serialNumber: UILabel!
    
    @IBOutlet weak var caseStatus: UILabel!
    
    @IBOutlet weak var caseType: UILabel!
    
    var caseStatusType: CaseStatus = .Pending {
        didSet {
            switch caseStatusType {
            case .Pending:
                caseStatus.text = StatusConstants.Pending
            case .Accepted:
                caseStatus.text = StatusConstants.Accepted
            case .Failed:
                caseStatus.text = StatusConstants.Failed
            }
        }
    }
    
    struct StatusConstants {
        static let Pending = "審核中"
        static let Failed = "未受理"
        static let Accepted = "已受理"
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
