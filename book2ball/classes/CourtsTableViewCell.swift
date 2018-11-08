//
//  CourtsTableViewCell.swift
//  book2ball
//
//  Created by Gene Tenorlas on 2018-10-31.
//  Copyright © 2018 MAGS. All rights reserved.
//
/*
 This Class will design how the table cell will look like in the CourtsViewController classs.
 */

import UIKit

class CourtsTableViewCell: UITableViewCell {
    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let arrowImage = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
     
        //configure primaryLabel
        primaryLabel.textAlignment = NSTextAlignment.left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 26)
        primaryLabel.backgroundColor = UIColor.clear
        primaryLabel.textColor = UIColor.black
        
        //configure secondaryLabel
        secondaryLabel.textAlignment = NSTextAlignment.left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        secondaryLabel.backgroundColor = UIColor.clear
        secondaryLabel.textColor = UIColor(red: 82.0/255, green: 103.0/255, blue: 137.0/255, alpha: 1.0)
        
        //All all the subviews
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(arrowImage)
    }
    
    //define the size and location of all 3 items as below
    override func layoutSubviews() {
        //primaryLabel location on the cell
        var f = CGRect(x: 16, y: 5, width: 325, height: 30)
        primaryLabel.frame = f
        
        //secondaryLabel location on the cell
        f = CGRect(x: 16, y: 40, width: 330, height: 20)
        secondaryLabel.frame = f
        
        //arrowImage location on the cell
        f = CGRect(x: 330, y: 5, width: 40, height: 45)
        arrowImage.frame = f
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
