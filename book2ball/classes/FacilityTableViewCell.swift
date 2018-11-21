//
//  FacilityTableViewCell.swift
//  book2ball
//
//  Created by Xcode User on 2018-11-21.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

class FacilityTableViewCell: UITableViewCell {
    
    @IBOutlet var cellView : UIView!
    @IBOutlet var facilityName : UILabel!
    @IBOutlet var facilityAddress : UILabel!
    @IBOutlet var facilityDistance : UILabel!
    @IBOutlet var select : UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
