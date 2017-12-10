//
//  FeedCell.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 11/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    

    func updateCell(image: UIImage, email: String, content: String){
        profileImage.image = image
        emailLabel.text = email
        contentLabel.text = content
    }
    
    
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
