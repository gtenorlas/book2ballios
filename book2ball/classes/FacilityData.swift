//
//  FacilityData.swift
//
//  Created by Chathu Anthony User on 2018-04-10.
//  Copyright © 2018 Xcode User. All rights reserved.
//
//  The purpose of this class is to hold the facility information which the customer
//  can rent one of their courts.

import UIKit

class FacilityData: NSObject {

    var id: Int
    var facilityName: NSString
    var contactNumber: NSString
    var website: NSString
    var icon: NSString
    var address: NSString
    var city: NSString
    var creationDate: NSString
    var endDate: NSString
    
    public override init() {
        self.id=0
        self.facilityName = ""
        self.contactNumber = ""
        self.website = ""
        self.icon = ""
        self.address = ""
        self.city = ""
        self.creationDate = ""
        self.endDate = ""
    }
    public init(id:Int, facilityName:NSString, contact:NSString, website:NSString, icon:NSString, address:NSString, city:NSString, creationDate:NSString, endDate:NSString ){
        self.id = id
        self.facilityName = facilityName
        self.contactNumber = contact
        self.website = website
        self.icon = icon
        self.address = address
        self.city = city
        self.creationDate = creationDate
        self.endDate = endDate
    }
}
