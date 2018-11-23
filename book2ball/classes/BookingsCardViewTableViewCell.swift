//
//  BookingsCardViewTableViewCell.swift
//  book2ball
//
//  Created by Admin on 2018-11-23.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

class BookingsCardViewTableViewCell: UITableViewCell {
    @IBOutlet var cellView : UIView!
    @IBOutlet var facilityName : UILabel!
    @IBOutlet var duration : UILabel!
    @IBOutlet var start : UILabel!
    @IBOutlet var end : UILabel!
    @IBOutlet var select : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
