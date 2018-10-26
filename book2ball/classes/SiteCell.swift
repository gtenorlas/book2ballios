//
//  SiteCell.swift
//  book2ball
//
//  Created by Xcode User on 2018-10-24.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import Foundation
import UIKit

class SiteCell: UITableViewCell {
    
    let facilityName = UILabel()
    let city = UILabel()
    let province = UILabel()
    let distance = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        facilityName.textAlignment = .left
        facilityName.font = UIFont.boldSystemFont(ofSize: 30)
        facilityName.backgroundColor = .clear
        facilityName.textColor = .black
        
        city.textAlignment = .left
        city.font = UIFont.boldSystemFont(ofSize: 12)
        city.backgroundColor = .clear
        city.textColor = .blue
        
        province.textAlignment = .left
        province.font = UIFont.boldSystemFont(ofSize: 12)
        province.backgroundColor = .clear
        province.textColor = .blue
        
        distance.textAlignment = .right
        distance.font = UIFont.boldSystemFont(ofSize: 12)
        distance.backgroundColor = .clear
        distance.textColor = .blue
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(facilityName)
        contentView.addSubview(city)
        contentView.addSubview(province)
        contentView.addSubview(distance)
        
    }
    
    override func layoutSubviews() {
        facilityName.frame = CGRect(x: 20, y: 5, width: 300, height: 30)
        province.frame = CGRect(x: 130, y: 30, width: 100, height: 20)
        city.frame = CGRect(x: 20, y: 30, width: 100, height: 20)
        distance.frame = CGRect(x: 250, y: 30, width: 120, height: 20)
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
