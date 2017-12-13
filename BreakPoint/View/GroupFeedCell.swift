//
//  groupFeedCell.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 14/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    func updateCell(profileImage:UIImage, email: String, message: String){
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        self.messageLabel.text = message
    }
}
