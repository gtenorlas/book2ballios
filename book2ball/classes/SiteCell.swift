//
//  SiteCell.swift
//  MAGS
//
//  Created by Xcode User on 2018-10-24.
//  Copyright © 2018 moghid saad. All rights reserved.
//
/*
 This Class will design how the table cell will look like in the SearchFacilityViewController classs.
 */

import Foundation
import UIKit

class SiteCell: UITableViewCell {
    
    let facilityName = UILabel()
    let city = UILabel()
    let province = UILabel()
    let distance = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        facilityName.textAlignment = .left
        facilityName.font = UIFont.boldSystemFont(ofSize: 20)
        facilityName.backgroundColor = .clear
        facilityName.textColor = .black
        
        city.textAlignment = .left
        city.font = UIFont.boldSystemFont(ofSize: 15)
        city.backgroundColor = .clear
        city.textColor = UIColor(red: 82.0/255, green: 103.0/255, blue: 137.0/255, alpha: 1.0)
        
        province.textAlignment = .left
        province.font = UIFont.boldSystemFont(ofSize: 15)
        province.backgroundColor = .clear
        province.textColor = UIColor(red: 82.0/255, green: 103.0/255, blue: 137.0/255, alpha: 1.0)
        
        distance.textAlignment = .right
        distance.font = UIFont.boldSystemFont(ofSize: 15)
        distance.backgroundColor = .clear
        distance.textColor = UIColor(red: 82.0/255, green: 103.0/255, blue: 137.0/255, alpha: 1.0)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(facilityName)
        contentView.addSubview(city)
        contentView.addSubview(province)
        contentView.addSubview(distance)
        
    }
    
    override func layoutSubviews() {
        facilityName.frame = CGRect(x: 20, y: 5, width: 220, height: 30)
        province.frame = CGRect(x: 130, y: 30, width: 100, height: 20)
        city.frame = CGRect(x: 20, y: 30, width: 100, height: 20)
        distance.frame = CGRect(x: 220, y: 30, width: 140, height: 20)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
