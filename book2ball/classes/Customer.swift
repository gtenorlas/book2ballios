//
//  Registration.swift
//  SQLiteNew
//
//  Created by Gene Teniorlas User on 2018-03-29.
//  Copyright © 2018 Xcode User. All rights reserved.
//  The purpose of this class is to hold the new customer registration and to hold the user that is currently logged in to the application

import UIKit
let DomainURL = "http://mags.website/api/customer/"

class Customer: NSObject, Codable {
    
    var username:NSString
    var password:NSString
    var firstName: NSString
    var lastName: NSString
    var email:NSString
    var contactNumber: NSString
    var startDate: NSString
    var endDate: NSString
    var status: NSString
    var originate: NSString
    
    //constructor without arguments
    public override init() {
        
        self.username = ""
        self.password = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.contactNumber = ""
        self.startDate = ""
        self.endDate = ""
        self.status = ""
        self.originate = ""
        
    }
    
    //constructor with arguments
    public init( username:NSString, password:NSString, firstName: NSString, lastName: NSString, email:NSString, contactNumber: NSString, startDate: NSString, endDate: NSString, status: NSString, originate: NSString){
        
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.contactNumber = contactNumber
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
        self.originate = originate
    }
    
    enum CodingKeys : String, CodingKey {
       // case username = "id"
        case username, password, firstName, lastName, email, contactNumber, startDate, endDate, status, originate
    }
    
    required init (from decoder: Decoder) throws {
        let container =  try decoder.container (keyedBy: CodingKeys.self)
        username = try container.decode (String.self, forKey: .username) as NSString
        password = try container.decode (String.self, forKey: .password) as NSString
        firstName = try container.decode (String.self, forKey: .firstName) as NSString
        lastName = try container.decode (String.self, forKey: .lastName) as NSString
        email = try container.decode (String.self, forKey: .email) as NSString
        contactNumber = try container.decode (String.self, forKey: .contactNumber) as NSString
        startDate = try container.decode (String.self, forKey: .startDate) as NSString
        endDate = try container.decode (String.self, forKey: .endDate) as NSString
        status = try container.decode (String.self, forKey: .status) as NSString
        originate = try container.decode (String.self, forKey: .originate) as NSString
    }
    func encode (to encoder: Encoder) throws
    {
        do {
        var container = encoder.container (keyedBy: CodingKeys.self)
        try container.encode (username as String, forKey: .username)
        try container.encode (password as String, forKey: .password)
        try container.encode (firstName as String, forKey: .firstName)
        try container.encode (lastName as String, forKey: .lastName)
        try container.encode (email as String, forKey: .email)
        try container.encode (contactNumber as String, forKey: .contactNumber)
        try container.encode (startDate as String, forKey: .startDate)
        try container.encode (endDate as String, forKey: .endDate)
        try container.encode (status as String, forKey: .status)
        try container.encode (originate as String, forKey: .originate)
        } catch {
            print(error)
        }
    }
    
    
    func saveToServer() {
       // let urlString = DomainURL
        
        var req = URLRequest.init(url: URL.init(string: DomainURL)!)
        req.httpMethod = "POST"
        req.httpBody = try? JSONEncoder().encode(self)
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            print (String.init(data: data!, encoding: .ascii) ?? "no data")
        }
        task.resume()
    }

}
