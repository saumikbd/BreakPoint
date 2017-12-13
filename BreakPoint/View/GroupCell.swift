//
//  GroupCell.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 13/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var membersNumberLabel: UILabel!
    
    func updateCell(title:String, description: String, memberNumber: Int) {
        titleLabel.text = title
        descriptionLabel.text = description
        membersNumberLabel.text = "\(memberNumber) members"
    }
}
