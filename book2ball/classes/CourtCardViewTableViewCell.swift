//
//  CourtCardViewTableViewCell.swift
//  book2ball
//
//  Created by Admin on 2018-11-22.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

class CourtCardViewTableViewCell: UITableViewCell {

    @IBOutlet var cellView : UIView!
    @IBOutlet var courtName : UILabel!
    @IBOutlet var courtType : UILabel!
    @IBOutlet var courtDescription : UILabel!
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
