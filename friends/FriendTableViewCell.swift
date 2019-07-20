//
//  FriendTableViewCell.swift
//  friends
//
//  Created by Faith on 6/7/19.
//  Copyright © 2019 Faith. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
  
  
  @IBOutlet weak var profileImage: UIImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var schoolLabel: UILabel!
  
  @IBOutlet weak var ageLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
}
