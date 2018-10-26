//
//  FacilityData.swift
//
//  Created by Chathu Anthony User on 2018-04-10.
//  Copyright © 2018 Xcode User. All rights reserved.
//
//  The purpose of this class is to hold the facility information which the customer
//  can rent one of their courts.

import UIKit
/*
let FacilityURL = "http://mags.website/api/facility/"

class FacilityData: NSObject, Codable {

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
    
    enum CodingKeys : String, CodingKey {
        // case username = "id"
        case id, facilityName, contactNumber, website, icon, address, city, creationDate, endDate
    }
    
    required init (from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //let container =  try decoder.container (keyedBy: CodingKeys.self)
        id = try values.decode (Int.self, forKey: .id) as Int
        facilityName = try values.decode (String.self, forKey: .facilityName) as NSString
        contactNumber = try values.decode (String.self, forKey: .contactNumber) as NSString
        website = try values.decode (String.self, forKey: .website) as NSString
        icon = try values.decode (String.self, forKey: .icon) as NSString
        address = try values.decode (String.self, forKey: .address) as NSString
        city = try values.decode (String.self, forKey: .city) as NSString
        creationDate = try values.decode (String.self, forKey: .creationDate) as NSString
        endDate = try values.decode (String.self, forKey: .endDate) as NSString
    }
    func encode (to encoder: Encoder) throws
    {
        do {
            var container = encoder.container (keyedBy: CodingKeys.self)
            try container.encode (id as Int, forKey: .id)
            try container.encode (facilityName as String, forKey: .facilityName)
            try container.encode (contactNumber as String, forKey: .contactNumber)
            try container.encode (website as String, forKey: .website)
            try container.encode (icon as String, forKey: .icon)
            try container.encode (address as String, forKey: .address)
            try container.encode (city as String, forKey: .city)
            try container.encode (creationDate as String, forKey: .creationDate)
            try container.encode (endDate as String, forKey: .endDate)
        } catch {
            print(error)
        }
    }
    
  

}*/
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
    var courtsList: Array<CourtData> = []
    
    
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
    }
    public init(id:Int, facilityName:NSString, facilityDesc:NSString,addLine1:NSString, addLine2:NSString, addLine3:NSString,city:NSString,province:NSString,postalCode:NSString,country:NSString, contact:NSString, distance:Double, courtsList: Array<CourtData> ){
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
    }
}
