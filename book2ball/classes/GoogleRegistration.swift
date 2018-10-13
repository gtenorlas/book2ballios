//
//  GoogleRegistration.swift
//  Book2Ball
//
//  Created by Moghid Saad User on 2018-04-19.
//  Copyright © 2018 Xcode User. All rights reserved.
//
//  Class for customers logging in using their google account
//  Subclass of Registration


import UIKit

class GoogleRegistration: Registration {
    var googleUserId: String
    var googleUserToken: String
    
    public init(googleUserId: String, googleUserToken: String){
        self.googleUserId = googleUserId
        self.googleUserToken = googleUserToken
        super.init() //initialize the parent class
    }

}
