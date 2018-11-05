//
//  Booking.swift
//  book2ball
//
//  Created by Xcode User on 2018-11-02.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit
class Booking: NSObject {
    var bookingId:Int?
    var customerEmail:NSString?
    var customerName:NSString?
    var bookingDate:Date?
    var bookingType:NSString?
    var status:NSString?
    var startDateTime:Date?
    var endDateTime:Date?
    var duration:Int?
    var court:Court?
    var comment:NSString?
    var payment:Payment?
    var facilityName:NSString?
    var courtName:NSString?
    
    public override init() {
        
    }
    
    public init(customerEmail : NSString, customerName : NSString , bookingType:NSString, status:NSString, startDateTime:Date, endDateTime:Date, duration:Int, court:Court , comment:NSString, payment:Payment , facilityName:NSString, courtName:NSString){
        
        self.customerEmail = customerEmail
        self.customerName = customerName
        self.bookingType = bookingType
        self.status = status
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
        self.duration = duration
        self.court = court
        self.comment = comment
        self.payment = payment
        self.facilityName = facilityName
        self.courtName = courtName
        
    }
    static func save(booking:Booking) -> Any {
        var fetchedResponse : (Any)? = nil
        var baseURL = "http://mags.website/api/booking/"
       // baseURL += "\(booking.bookingId!)/"
        baseURL += "\(booking.customerEmail!)/"
        baseURL += "\(booking.customerName!)/"
       // baseURL += "\(booking.bookingDate!)/"
        baseURL += "\(booking.bookingType!)/"
        baseURL += "\(booking.status!)/"
        
        var dateFormatter = DateFormatter()
        let newStartDate : String
        dateFormatter.dateFormat = "MM-dd-yyyy-HH-mm"
        var strDate = dateFormatter.string(from: booking.startDateTime!)
        newStartDate  = strDate
        
        baseURL += newStartDate
        baseURL += "/"
       // var dateFormatter = DateFormatter()
        let newEndDate : String
        dateFormatter.dateFormat = "MM-dd-yyyy-HH-mm"
        strDate = dateFormatter.string(from: booking.endDateTime!)
        newEndDate  = strDate
        baseURL += newEndDate
        baseURL += "/"
        baseURL += "\(booking.duration!)/"
        baseURL += "\(booking.court!.courtNumber)/"
       // baseURL += "\(booking.comment!)/"
      //  baseURL += "\(booking.payment!)"
        let aString = "\(booking.facilityName!)"
        let newString = aString.replacingOccurrences(of: " ", with: "%20")
        baseURL += newString
        
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
    
    static func fetch(booking:Booking)->Any{
        var fetchedBooking : (Any)? = nil
       // var fetchedBooking : Array<Any> = Array()
        var baseURL = "http://mags.website/api/booking/email/"
        // baseURL += "\(booking.bookingId!)/"
        baseURL += "\(booking.customerEmail!)/"
        baseURL += "\(booking.customerName!)/"
        // baseURL += "\(booking.bookingDate!)/"
        baseURL += "\(booking.bookingType!)/"
        baseURL += "\(booking.status!)/"
        baseURL += "\(booking.startDateTime!)/"
        baseURL += "\(booking.endDateTime!)"
        baseURL += "\(booking.duration!)/"
        baseURL += "\(booking.court?.courtNumber)/"
        // baseURL += "\(booking.comment!)/"
        //  baseURL += "\(booking.payment!)"
        baseURL += "\(booking.facilityName!)"
        
        print(baseURL)
        
        // create post request
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
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
                    
                   // booking.bookingId = dict["bookingId"] as! Int
                    booking.customerEmail = dict["customerEmail"] as? NSString
                    booking.customerName = dict["customerName"] as? NSString
                   // booking.bookingDate = dict["bookingDate"] as! Date
                    booking.bookingType = dict["bookingType"] as? NSString
                    booking.status = dict["status"] as? NSString
                    booking.startDateTime = dict["startDateTime"] as! Date
                    booking.endDateTime = dict["endDateTime"] as! Date
                    booking.duration = dict["duration"] as! Int
                    booking.court?.courtNumber = dict["court"] as! Int
                   // booking.comment = dict["comment"] as? NSString
                   // booking.payment = dict["payment"] as! Payment
                    booking.facilityName = dict["facilityName"] as? NSString
                    //print ("customer name is \(customer.firstName)")
                    fetchedBooking = booking
                    
                }
            }else {
                fetchedBooking =  String.init(data: data!, encoding: .ascii)
            }
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
        // task.resume()
        
        print ("its here")
        return fetchedBooking
        
        
    }
    
    func generateDate()->Date{
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = 1980
        dateComponents.month = 7
        dateComponents.day = 11
        dateComponents.timeZone = TimeZone(abbreviation: "JST") // Japan Standard Time
        dateComponents.hour = 8
        dateComponents.minute = 34
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let someDateTime = userCalendar.date(from: dateComponents)
        return someDateTime!
    }
    
    static func fetchByEmail(email: String) -> Array<Booking>{
        //var status:String=""
        let semaphore = DispatchSemaphore(value: 0) //make it synchrounous
        var fetchedBookings : Array<Booking> = Array()
        // create post request
        let url = NSURL(string: "http://mags.website/api/booking/email/\(email)/")!
        print ("urlToFetch -> \(url)")
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
        // insert json data to the request
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            print (String.init(data: data!, encoding: .ascii) ?? "no data")
            
            //Use JSONSerialization to handle the data that is received
            if let jsonResponse = try? JSONSerialization.jsonObject(with: data!, options: []) {
                print ("done serialization")
                print (jsonResponse)
                
                guard let jsonArray = jsonResponse as? [[String : Any]] else {return}
                
                for bookingJson in jsonArray {
                    let dict = bookingJson
                    print("yes it is a dictionary")
                    let booking =  Booking()
                    booking.bookingId = dict["bookingId"] as? Int
                    booking.bookingDate = Booking.setDate(data: dict["bookingDate"])
                    booking.bookingType = dict["bookingType"] as? NSString
                    booking.comment = dict["comment"] as? NSString
                    booking.customerName = dict["customerName"] as? NSString
                    booking.customerEmail = dict["customerEmail"] as? NSString
                    booking.duration = dict["duration"] as? Int
                    booking.endDateTime = Booking.setDate(data:dict["endDateTime"])
                    booking.facilityName = dict["facilityName"] as? NSString
                    booking.startDateTime = Booking.setDate(data:dict["startDateTime"])
                    booking.status = dict["status"] as? NSString
                    booking.payment = Payment.fetch(data: dict["payment"])
                    booking.courtName = dict["courtName"] as? NSString
                    
                    print("Payment is " + (booking.payment?.toString())!)
                    fetchedBookings.append(booking)
                }
            }else {
                fetchedBookings =  []
                
            }
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        return fetchedBookings
    }
    
    
    static func setDate(data:Any) -> Date{
        
        guard let dict = data as? [String : Any] else {return Date()}
        var dateComponents = DateComponents()
        dateComponents.year = (dict["year"] as? Int)!
        dateComponents.month = (dict["monthValue"] as? Int)!
        dateComponents.day = (dict["dayOfMonth"] as? Int)!
        dateComponents.timeZone = TimeZone(abbreviation: "BST") // EET, CET Standard Time
        dateComponents.hour = (dict["hour"] as? Int)!
        dateComponents.minute = (dict["minute"] as? Int)!
        dateComponents.second = 0
        
        
        var calendar = Calendar(identifier: .iso8601)
        // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let someDateTime = calendar.date(from: dateComponents)
        print (Booking.formatDate(date: someDateTime!))
        return someDateTime!
    }
    
    static func formatDate(date:Date) -> String {
        let formatterShort = DateFormatter()
        formatterShort.calendar = Calendar(identifier: .iso8601)
        formatterShort.locale = Locale(identifier: "US_en")
        formatterShort.dateFormat = "E, dd MMM yyyy h:mm a"
        //formatterShort.timeZone = TimeZone(abbreviation: "EST")
        let formattedDate = formatterShort.string(from: date)
        return formattedDate
    }
    public func toString() -> String {
        var data = ""
        data += "bookingId: \(self.bookingId) "
        data += "bookingDate: \(Booking.formatDate(date: self.bookingDate!)) "
        data += "bookingType: \(self.bookingType) "
        data += "comment: \(self.comment) "
        data += "Email: \(self.customerEmail) "
        data += "Contact: \(self.customerName) "
        data += "duration: \(self.duration) "
        data += "startDateTime: \(Booking.formatDate(date: self.startDateTime!)) "
        data += "endDateTime: \(Booking.formatDate(date: self.endDateTime!)) "
        data += "Status: \(self.status!) "
        
        return data
    }
    
    
}
 
