//
//
//  Created by Gene Teniorlas User on 2018-10-29.
//  Copyright © 2018 Xcode User. All rights reserved.
//  The purpose of this class is to hold the new customer registration and to hold the user that is currently logged in to the application

import UIKit
//let DomainURL = "http://mags.website/api/customer/"
var baseURL = "http://mags.website/api/customer/"

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
    
    required init (from decoder: Decoder) throws {
        let values =  try decoder.container (keyedBy: CodingKeys.self)
        username = try values.decode (String.self, forKey: .username) as NSString
        password = try values.decode (String.self, forKey: .password) as NSString
        firstName = try values.decode (String.self, forKey: .firstName) as NSString
        lastName = try values.decode (String.self, forKey: .lastName) as NSString
        email = try values.decode (String.self, forKey: .email) as NSString
        contactNumber = try values.decode (String.self, forKey: .contactNumber) as NSString
        startDate = try values.decode (String.self, forKey: .startDate) as NSString
        endDate = try values.decode (String.self, forKey: .endDate) as NSString
        status = try values.decode (String.self, forKey: .status) as NSString
        originate = try values.decode (String.self, forKey: .originate) as NSString
    }
    
    static func save(customer:Customer) -> Any {
        var fetchedResponse : (Any)? = nil
        
        var baseURL = "http://mags.website/api/customer/"
        baseURL += "\(customer.username)/"
        baseURL += "\(customer.password)/"
        baseURL += "\(customer.firstName)/"
        baseURL += "\(customer.lastName)/"
        baseURL += "\(customer.email)/"
        baseURL += "\(customer.contactNumber)/"
        baseURL += "\(customer.startDate)/"
        baseURL += "\(customer.endDate)/"
        baseURL += "\(customer.status)/"
        baseURL += "\(customer.originate)"
        
        print(baseURL)
        
        // create post request
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let semaphore = DispatchSemaphore(value: 0) //make it synchrounous
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            print ("response -> \(response)")
            print ("data -> " + String.init(data: data!, encoding: .ascii)! ?? "no data")
            
            fetchedResponse =  String.init(data: data!, encoding: .ascii)
            
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
        print ("its here")
        return fetchedResponse!
        
    }
    
    static func saveUpdatedProfile(customer:Customer) -> Any {
        var fetchedResponse : (Any)? = nil
        
        var baseURL = "http://mags.website/api/customer/update/"
        baseURL += "\(customer.username)/"
        baseURL += "\(customer.password)/"
        baseURL += "\(customer.firstName)/"
        baseURL += "\(customer.lastName)/"
        baseURL += "\(customer.email)/"
        baseURL += "\(customer.contactNumber)/"
        baseURL += "\(customer.startDate)/"
        baseURL += "\(customer.endDate)/"
        baseURL += "\(customer.status)/"
        baseURL += "\(customer.originate)"
        
        print(baseURL)
        
        // create post request
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let semaphore = DispatchSemaphore(value: 0) //make it synchrounous
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            print ("response -> \(response)")
            print ("data -> " + String.init(data: data!, encoding: .ascii)! ?? "no data")
            
            fetchedResponse =  String.init(data: data!, encoding: .ascii)
            
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
        print ("its here")
        return fetchedResponse!
        
    }
    
    static func fetch(customer:Customer)->Any{
        var fetchedCustomer : (Any)? = nil
        var baseURL = "http://mags.website/api/customer/"
        baseURL += "\(customer.username)/"
        baseURL += "\(customer.password)/"
        baseURL += "\(customer.originate)"
        
        print(baseURL)
        
        // create post request
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        //var status:String=""
        let semaphore = DispatchSemaphore(value: 0) //make it synchrounous
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            print ("response -> \(response)")
            
            print ("data -> " + String.init(data: data!, encoding: .ascii)! ?? "no data")
            
            
            
            //Use JSONSerialization to handle the data that is received
            if let objData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) {
                
                print ("done serialization")
                //print (objData)
                if let dict = objData as? [String:Any] {
                    print("yes it is a dictionary")
                    //grabbing the data from dictionary and saving it to the customer attributes
                    customer.contactNumber = (dict["contactNumber"] as? NSString)!
                    customer.email = (dict["email"] as? NSString)!
                    customer.firstName = (dict["firstName"] as? NSString)!
                    customer.lastName = (dict["lastName"] as? NSString)!
                    customer.status = (dict["status"] as? NSString)!
                    //print ("customer name is \(customer.firstName)")
                    fetchedCustomer = customer
                    
                }
            }else {
                fetchedCustomer =  String.init(data: data!, encoding: .ascii)
            }
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
        // task.resume()
        
        print ("its here")
        return fetchedCustomer
        
        
    }
    /*
     facebook and google
 */
    static func fetchAccount(customer:Customer)->Any{
        var fetchedCustomer : (Any)? = nil
        var baseURL = "http://mags.website/api/customer/"
        baseURL += "\(customer.email)/"
        //baseURL += "\(customer.firstName)/"
        baseURL += "null/"
        baseURL += "\(customer.originate)"
        print(baseURL)
        
        // create post request
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        //var status:String=""
        let semaphore = DispatchSemaphore(value: 0) //make it synchrounous
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            print ("response -> \(response)")
            
            print ("data -> " + String.init(data: data!, encoding: .ascii)! ?? "no data")
            
            
            
            //Use JSONSerialization to handle the data that is received
            if let objData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) {
                
                print ("done serialization")
                //print (objData)
                if let dict = objData as? [String:Any] {
                    print("yes it is a dictionary")
                    //grabbing the data from dictionary and saving it to the customer attributes
                    customer.username = (dict["username"] as? NSString)!
                    customer.contactNumber = (dict["contactNumber"] as? NSString)!
                    customer.email = (dict["email"] as? NSString)!
                    customer.firstName = (dict["firstName"] as? NSString)!
                    customer.lastName = (dict["lastName"] as? NSString)!
                    customer.status = (dict["status"] as? NSString)!
                    customer.originate = (dict["originate"] as? NSString)!
                    //print ("customer name is \(customer.firstName)")
                    fetchedCustomer = customer
                    
                }
            }else {
                fetchedCustomer =  String.init(data: data!, encoding: .ascii)
            }
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
        // task.resume()
        
        print ("its here")
        return fetchedCustomer
        
        
    }
    
    /*returns "invalid" or "success"    */
    static func sendToken(email:String!)->Any{
        var fetchedResponse : (Any)? = nil
        var baseURL = "http://mags.website/api/customer/token/"
        baseURL += "\(email!)/"
        print(baseURL)
        
        // create post request
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let semaphore = DispatchSemaphore(value: 0) //make it synchrounous
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            print ("response -> \(response)")
            print ("data -> " + String.init(data: data!, encoding: .ascii)! ?? "no data")
            
            fetchedResponse =  String.init(data: data!, encoding: .ascii)
            
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
        print ("its here")
        return fetchedResponse!
    }
    
    /*returns "invalid" or "success"    */
    static func validateToken(email: String!, tokenToValidate:String!)->Any{
        var fetchedResponse : (Any)? = nil
        var baseURL = "http://mags.website/api/customer/token/validate/"
        baseURL += "\(email!)/"
        baseURL += "\(tokenToValidate!)/"
        print(baseURL)
        
        // create post request
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let semaphore = DispatchSemaphore(value: 0) //make it synchrounous
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            print ("response -> \(response)")
            print ("data -> " + String.init(data: data!, encoding: .ascii)! ?? "no data")
            
            fetchedResponse =  String.init(data: data!, encoding: .ascii)
            
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
        print ("its here")
        return fetchedResponse!
    }
    
    /*returns "invalid" or "success"    */
    static func resetPassword(email: String!, newPassword:String!)->Any{
        var fetchedResponse : (Any)? = nil
        var baseURL = "http://mags.website/api/customer/reset/"
        baseURL += "\(email!)/"
        baseURL += "\(newPassword!)/"
        print(baseURL)
        
        // create post request
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let semaphore = DispatchSemaphore(value: 0) //make it synchrounous
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            print ("response -> \(response)")
            print ("data -> " + String.init(data: data!, encoding: .ascii)! ?? "no data")
            
            fetchedResponse =  String.init(data: data!, encoding: .ascii)
            
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
        print ("its here")
        return fetchedResponse!
    }
    
    public func toString() -> String {
        var data = ""
        data += "Username: \(self.username) "
        data += "Password: \(self.password) "
        data += "Firstname: \(self.firstName) "
        data += "Lastname: \(self.lastName) "
        data += "Email: \(self.email) "
        data += "Contact: \(self.contactNumber ?? "") "
        data += "Start Date: \(self.startDate ?? "") "
        data += "End Date: \(self.endDate ?? "") "
        data += "Status: \(self.status) "
        data += "Originate: \(self.originate)"
        return data
    }
    
}
