//
//  UserCell.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 13/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    
    func updateCell(profileImage:UIImage, email: String, isSelected: Bool){
        self.profileImage.image = profileImage
        emailLabel.text = email
        if isSelected {
            checkImage.isHidden = false
        } else {
            checkImage.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
