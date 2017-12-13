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
    var showing = false
    
    func updateCell(profileImage:UIImage, email: String, isSelected: Bool){
        self.profileImage.image = profileImage
        emailLabel.text = email
        if isSelected {
            checkImage.isHidden = false
            showing = true
        } else {
            checkImage.isHidden = true
            showing = false
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            if showing {
                checkImage.isHidden = true
            } else {
                checkImage.isHidden = false                
            }
        }
    }

}
