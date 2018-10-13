//
//  Registration.swift
//  SQLiteNew
//
//  Created by Gene Teniorlas User on 2018-03-29.
//  Copyright © 2018 Xcode User. All rights reserved.
//  The purpose of this class is to hold the new customer registration and to hold the user that is currently logged in to the application

import UIKit

class Registration: NSObject {
    var id: Int
    var username:NSString
    var password:NSString
    var firstName: NSString
    var lastName: NSString
    var email:NSString
    
    //constructor without arguments
    public override init() {
        self.id=0
        self.username = ""
        self.password = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        
    }
    
    //constructor with arguments
    public init(id:Int, username:NSString, password:NSString, firstName: NSString, lastName: NSString, email:NSString){
        self.id = id
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    


}
