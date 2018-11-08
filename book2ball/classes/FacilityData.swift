//
//  FacilityData.swift
//
//  Created by Chathu Anthony User on 2018-10-10.
//  Copyright © 2018 Xcode User. All rights reserved.
//
//  The purpose of this class is to hold the facility information which the customer
//  can rent one of their courts.

import UIKit

class FacilityData: NSObject {
    
    var facilityId: Int
    var facilityName: NSString
    var facilityDescription: NSString
    var addLine1:NSString
    var addLine2:NSString
    var addLine3:NSString
    var city: NSString
    var province: NSString
    var postalCode: NSString
    var country: NSString
    var contactNumber: NSString
    var distance: Double
    var courtsList: Array<Court> = []
    var lat: Double
    var long:Double
    
    
    public override init() {
        self.facilityId=0
        self.facilityName = ""
        self.facilityDescription = ""
        self.addLine1 = ""
        self.addLine2 = ""
        self.addLine3 = ""
        self.city = ""
        self.province = ""
        self.postalCode = ""
        self.country = ""
        self.contactNumber = ""
        self.distance = 0.0
        self.courtsList = []
        self.lat = 0.00
        self.long = 0.00
    }
    public init(id:Int, facilityName:NSString, facilityDesc:NSString,addLine1:NSString, addLine2:NSString, addLine3:NSString,city:NSString,province:NSString,postalCode:NSString,country:NSString, contact:NSString, distance:Double, courtsList: Array<Court>,lat:Double, long:Double ){
        self.facilityId = id
        self.facilityName = facilityName
        self.facilityDescription = facilityDesc
        self.addLine1 = addLine1
        self.addLine2 = addLine2
        self.addLine3 = addLine3
        self.city = city
        self.province = province
        self.postalCode = postalCode
        self.country = country
        self.contactNumber = contact
        self.distance = distance
        self.courtsList = courtsList
        self.lat = lat
        self.long = long
    }
}
