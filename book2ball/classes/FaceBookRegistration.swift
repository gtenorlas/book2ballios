//
//  FaceBookRegistration.swift
//  Book2Ball
//
//  Created by  Shanu Shanu User on 2018-03-27.
//  Copyright © 2018 Xcode User. All rights reserved.
//  The purpose of this class is to fetch the data from the facebook user's account

import UIKit
import FBSDKLoginKit

class FaceBookRegistration: NSObject {
    
    override init() {
    }
  
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    //Get the facebook user information and create a user(Registration) to hold
    //the information of the user currently logged in to the system.
    func fetchProfile() -> Customer {
        print("profile fetched")
        let parameters = ["fields" : "email, first_name, last_name"]
        let user: Customer = Customer()
        FBSDKGraphRequest(graphPath:"me", parameters : parameters).start{( connection, result, error ) -> Void in
            if error != nil {
                print("error");
                return
            }
            else{
                if let dict = result as? [String : Any],
                    let email = dict["email"] as? String,
                    let first_name = dict["first_name"] as? String,
                    let last_name = dict["last_name"] as? String{
                    
                    user.email = email as NSString
                    user.firstName = first_name as NSString
                    user.lastName = last_name as NSString
                    print("Email is " + email)
                    print("First Name is " + first_name)
                    print("Last Name is " + last_name)
                }
            }
        }
        
        return user
    }
}
