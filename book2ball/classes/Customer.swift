//
//  Registration.swift
//  SQLiteNew
//
//  Created by Gene Teniorlas User on 2018-03-29.
//  Copyright © 2018 Xcode User. All rights reserved.
//  The purpose of this class is to hold the new customer registration and to hold the user that is currently logged in to the application

import UIKit

class Customer: NSObject {
    var id: Int
    var username:NSString
    var password:NSString
    var firstName: NSString
    var lastName: NSString
    var email:NSString
    var contactNumber: NSString
    var startDate: NSString
    var endDate: NSString
    var status: NSString
    
    //constructor without arguments
    public override init() {
        self.id=0
        self.username = ""
        self.password = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.contactNumber = ""
        self.startDate = ""
        self.endDate = ""
        self.status = ""
        
    }
    
    //constructor with arguments
    public init(id:Int, username:NSString, password:NSString, firstName: NSString, lastName: NSString, email:NSString, contactNumber: NSString, startDate: NSString, endDate: NSString, status: NSString){
        self.id = id
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.contactNumber = contactNumber
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
    }
    


}
