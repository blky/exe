//
//  UserCell.swift
//  Chat
//
//  Created by Cindy Zheng on 10/21/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelUserEmail: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelZip: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
