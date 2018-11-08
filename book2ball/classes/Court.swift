//
//  Court.swift
//
//  Created by Moghid Saad User on 2018-10-10.
//  Copyright © 2018 Xcode User. All rights reserved.
//

/*
   The purpose of this class is to hold the court information that are inside the facility
   Each facility can have multiple courts. This class also communicate in the remote database using RESTful services to grab all the active courts and available courts for a particular facility 
 */


import UIKit

class Court: NSObject {
    
    var courtNumber: Int
    var courtName: NSString
    var availability: NSString
    var maxPlayer : Int
    var courtType : NSString
    var price : Double
    var creationDate: NSString
    var endDate: NSString
    var facilityId: Int
    
    public override init() {
        self.courtNumber = 0
        self.courtName = ""
        self.availability = ""
        self.maxPlayer = 0
        self.courtType = ""
        self.price = 0.0
        self.creationDate = ""
        self.endDate = ""
        self.facilityId = 0
    }
    public init(id:Int, name:NSString, availability:NSString, player : Int ,courtType: NSString, price: Double, cDate:NSString, eDate: NSString, facilityId:Int){
        self.courtNumber = id
        self.courtName = name
        self.availability = availability
        self.maxPlayer = player
        self.courtType = courtType
        self.price = price
        self.creationDate = cDate
        self.endDate = eDate
        self.facilityId = facilityId
    }
    
    
    static func fetch(data:Any) -> Array<Court>{
        
        var fetchedCourts: Array<Court>=Array()
        //Use JSONSerialization to handle the data that is received
        
        
        guard let jsonArray = data as? [[String : Any]] else {return fetchedCourts}
        print("json -> \(jsonArray)")
        
        for courtJson in jsonArray {
            let dict = courtJson
            print("yes it is a dictionary")
            let court = Court()
            court.courtNumber = (dict["courtNumber"] as? Int)!
            court.courtName = (dict["courtName"] as? NSString)!
            court.availability = (dict["availability"] as? NSString)!
            court.maxPlayer = (dict["maxPlayer"] as? Int)!
            court.courtType = (dict["courtType"] as? NSString)!
            court.price = (dict["price"] as? Double)!
            print("court #: \(court.courtNumber)")
            if (court.availability.lowercased == "active") {
            fetchedCourts.append(court)
            }
        }
        
        
        return fetchedCourts
    }
    
    //validate if court is available
    static func fetch(facilityId:Int,startDateTime:String,endDateTime:String) -> Array<Court>{
        
        var fetchedCourts: Array<Court>=Array()
        var baseURL = "http://mags.website/api/court/"
        baseURL += "\(facilityId)/"
        baseURL += "\(startDateTime)/"
        baseURL += "\(endDateTime)/"
     
        
        print(baseURL)
        
        // create post request
        let url = NSURL(string: baseURL)!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
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
                fetchedCourts = Court.fetch(data: objData)
            }
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        

        return fetchedCourts
    }
    
}
