//
//  PaymentTableViewCell.swift
//  Book2Ball
//
//  Created by Gene Tenorlas User on 2018-10-19.
//  Copyright © 2018 Xcode User. All rights reserved.
//
/*
 This Class will design how the table cell will look like in the InvoiceDeailsViewController classs.
 */

import UIKit

class PaymentTableViewCell: UITableViewCell {
    
    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let thirdLabel = UILabel()
    let fourthLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        // step 11c - configure primaryLabel
        primaryLabel.textAlignment = NSTextAlignment.left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 20)
        primaryLabel.backgroundColor = UIColor.clear
        primaryLabel.textColor = UIColor.black
        
        // step 11d - configure secondaryLabel
        secondaryLabel.textAlignment = NSTextAlignment.left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 18)
        secondaryLabel.backgroundColor = UIColor.clear
        secondaryLabel.textColor = UIColor(red: 82.0/255, green: 103.0/255, blue: 137.0/255, alpha: 1.0)
        
        // step 11d - configure thirdLabel
        thirdLabel.textAlignment = NSTextAlignment.left
        thirdLabel.font = UIFont.boldSystemFont(ofSize: 18)
        thirdLabel.backgroundColor = UIColor.clear
        thirdLabel.textColor = UIColor(red: 82.0/255, green: 103.0/255, blue: 137.0/255, alpha: 1.0)
        
        // step 11d - configure thirdLabel
        fourthLabel.textAlignment = NSTextAlignment.left
        fourthLabel.font = UIFont.boldSystemFont(ofSize: 18)
        fourthLabel.backgroundColor = UIColor.clear
        fourthLabel.textColor = UIColor(red: 82.0/255, green: 103.0/255, blue: 137.0/255, alpha: 1.0)
        
        
        // step 11e - no configuring of myImageView needed, instead add all 3 items manually as below
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(thirdLabel)
        contentView.addSubview(fourthLabel)
        
    }
    
    // step 11g - define size and location of all 3 items as below
    // return to BookingsViewController.swift
    override func layoutSubviews() {
        
        var f = CGRect(x: 16, y: 5, width: 300, height: 30)
        primaryLabel.frame = f
        
        f = CGRect(x:16 , y: 35, width: 500, height: 20)
        secondaryLabel.frame = f
        
        f = CGRect(x: 16, y: 55, width: 500, height: 20)
        thirdLabel.frame = f
        
        f = CGRect(x: 16, y: 75, width: 500, height: 20)
        fourthLabel.frame = f
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
