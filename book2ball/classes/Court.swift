//
//  Court.swift
//
//  Created by Moghid Saad User on 2018-04-10.
//  Copyright © 2018 Xcode User. All rights reserved.
//
//  The purpose of this class is to hold the court information that are inside the facility
//  Each facility can have multiple courts.

import UIKit

class Court: NSObject {
    
    var courtNumber: Int
    var courtName: NSString
    var availability: NSString
    var maxPlayer : Int
    var creationDate: NSString
    var endDate: NSString
    var facilityId: Int
    
    public override init() {
        self.courtNumber = 0
        self.courtName = ""
        self.availability = ""
        self.maxPlayer = 0
        self.creationDate = ""
        self.endDate = ""
        self.facilityId = 0
    }
    public init(id:Int, name:NSString, availability:NSString, player : Int ,cDate:NSString, eDate: NSString, facilityId:Int){
        self.courtNumber = id
        self.courtName = name
        self.availability = availability
        self.maxPlayer = player
        self.creationDate = cDate
        self.endDate = eDate
        self.facilityId = facilityId
    }

}
