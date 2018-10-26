//
//  CourtData.swift
//  book2ball
//
//  Created by Xcode User on 2018-10-26.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit
class CourtData: NSObject {
    var courtNumber: Int
    var courtName: NSString
    var availability: NSString
    var maxPayer: Int
    var courtType: NSString
    var price: Double
    
    public override init() {
        self.courtNumber = 0
        self.courtName = ""
        self.availability = ""
        self.maxPayer = 0
        self.courtType = ""
        self.price = 0.00
    }
    
    public init(courtNumber:Int, courtName:NSString, availability:NSString, maxPayer:Int, courtType:NSString, price:Double){
        
        self.courtNumber = courtNumber
        self.courtName = courtName
        self.availability = availability
        self.maxPayer = maxPayer
        self.courtType = courtType
        self.price = price
    }
    
}
