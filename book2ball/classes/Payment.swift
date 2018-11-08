//
//  Payment.swift
//  payPalIntegration
//
//  Created by Chathu Anthony on 2018-04-13.
//  Copyright © 2018 Xcode User. All rights reserved.
//
//This purpose of this class is to create an invoice and to create a booking for a customer

import UIKit

//just a comment to remove

class Payment: NSObject {
    
    var booking : Booking?
    var paymentId: Int?
    var courtCharge : Double?
    var adminFee : Double?
    var subTotal : Double?
    var taxPercentage: Double?
    var taxAmount : Double?
    var totalAmount: Double?
    var paymentDateTime : Date?
    var confirmationNumber: String?
    var paymentMethod: String?
    var status: String?
    
    //constructor without arguments
    public override init() {
        self.paymentId = 0
        self.booking = Booking()
        self.courtCharge = 0.0
        self.adminFee = 0.0
        self.subTotal = 0.0
        self.taxPercentage = 0.0
        self.taxAmount = 0.0
        self.totalAmount = 0.0
        self.paymentDateTime = nil
        self.confirmationNumber = ""
        self.paymentMethod = ""
        self.status = ""
        
    }
    
    //constructor with arguments
    public init( booking: Booking, courtCharge: Double, adminFee: Double, subTotal: Double, taxPercentage: Double, taxAmount: Double, totalAmount: Double, paymentDateTime: Date, confirmationNumber: String, paymentMethod: String, status : String){
        
        self.booking = booking
        self.courtCharge = courtCharge
        self.adminFee = adminFee
        self.subTotal = subTotal
        self.taxPercentage = taxPercentage
        self.taxAmount = taxAmount
        self.totalAmount = totalAmount
        self.paymentDateTime = paymentDateTime
        self.confirmationNumber = confirmationNumber
        self.paymentMethod = paymentMethod
        self.status = status
    }
    /*
    init (facility:String,court:String,resDate:String,resStart:String,numOfHours:String)
    {
        super.init()
        let numberFormatter = NumberFormatter()
        let xfacCharge = numberFormatter.number(from: courtCharge)?.floatValue
        self.numOfHours = numOfHours
        let xHours = numberFormatter.number(from: numOfHours)?.floatValue
        self.subTotal=getSubTotal(facCharge:xfacCharge!,hours:xHours!)
        let xSubTotal=numberFormatter.number(from: subTotal!)?.floatValue
        self.tax = getTax(subTot: xSubTotal!)
        let xTax = numberFormatter.number(from: tax!)?.floatValue
        self.facility = facility
        self.court = court
        self.reservationDate = resDate
        self.reservationStartTime = resStart
        self.totalAmount = getTotal(subTot:xSubTotal!,tax:xTax!)
    }
    */
    
    //calculate tax
    func getTax(subTot:Float)->String
    {
        let xTax=(subTot * 0.13)
        let realValue=String(format: "%.2f", xTax)
        return realValue
    }
    
    //calculate the total amount owing with tax included
    func getTotal(subTot:Float,tax:Float)->String
    {
        let xTotal=(subTot+tax)
        let realValue=String(format: "%.2f", xTotal)
        return realValue
    }
    
    func getTotalInDouble(subTot:Double,tax:Double)->Double
    {
        let xTotal=(subTot+tax)
       // let realValue=String(format: "%.2f", xTotal)
        return xTotal
    }
    
    //calculate the amount owing without tax
    //based on facility charge * the amount of hours of rental
    func getSubTotal(facCharge:Double,hours:Int)->String
    {
        let sub=(facCharge * Double(hours))
        let realValue=String(format: "%.2f", sub)
        return realValue
    }
    func getSubTotalInDouble(facCharge:Double,hours:Int)->Double
    {
        let sub=(facCharge * Double(hours))
        //let realValue=String(format: "%.2f", sub)
        return Double(sub)
    }

    func setTaxAmount()  {
        self.taxAmount = ( self.subTotal! * (self.taxPercentage! / 100))
    }
    
    static func save(payment:Payment) -> Any {
        var fetchedResponse : (Any)? = nil
        var baseURL = "http://mags.website/api/payment/"
        baseURL += "\(payment.booking!.bookingId!)/"
        baseURL += "\(payment.courtCharge!)/"
        baseURL += "\(payment.adminFee!)/"
        baseURL += "\(payment.subTotal!)/"
        baseURL += "\(payment.taxPercentage!)/"
        baseURL += "\(payment.taxAmount!)/"
        baseURL += "\(payment.totalAmount!)/"
       // baseURL += "\(payment.paymentDateTime!)/"
        payment.confirmationNumber = "null"
        baseURL += "\(payment.confirmationNumber!)/"
        baseURL += "\(payment.paymentMethod!)/"
        baseURL += "\(payment.status!)"
        
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
    
    /*
    static func fetch(payment:Payment)->Any{
        var fetchedPayment : (Any)? = nil
        var baseURL = "http://mags.website/api/payment/"
        baseURL += "\(payment.booking)/"
        baseURL += "\(payment.courtCharge)/"
        baseURL += "\(payment.adminFee)/"
        baseURL += "\(payment.subTotal)/"
       // baseURL += "\(payment.taxPercentage)/"
        baseURL += "\(payment.taxAmount)/"
        baseURL += "\(payment.totalAmount)/"
        baseURL += "\(payment.paymentDateTime)/"
        baseURL += "\(payment.confirmationNumber)/"
        baseURL += "\(payment.paymentMethod)"
        baseURL += "\(payment.status)"
        
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
                    payment.booking = (dict["booking"])! as! Booking
                    payment.courtCharge = (dict["courtCharge"] )! as! Double
                    payment.adminFee = (dict["adminFee"])! as! Double
                    payment.subTotal = (dict["subTotal"])! as! Double
                    payment.taxPercentage = (dict["taxPercentage"] )! as! Double
                    payment.taxAmount = (dict["taxAmount"])! as! Double
                    payment.totalAmount = (dict["totalAmount"])! as! Double
                    payment.paymentDateTime = (dict["paymentDateTime"] )! as! Date
                    payment.confirmationNumber = (dict["confirmationNumber"] )! as! String
                    payment.paymentMethod = (dict["paymentMethod"] )! as! String
                    payment.status = (dict["status"] )! as! String
                    //print ("customer name is \(customer.firstName)")
                    fetchedPayment = payment
                    
                }
            }else {
                fetchedPayment =  String.init(data: data!, encoding: .ascii)
            }
            semaphore.signal()//wait for synchronous
            }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        
        // task.resume()
        
        print ("its here")
        return fetchedPayment
        
        
    }
 */
    static func setDate(data:Any) -> Date{
        
        guard let dict = data as? [String : Any] else {return Date()}
        var dateComponents = DateComponents()
        dateComponents.year = (dict["year"] as? Int)!
        dateComponents.month = (dict["monthValue"] as? Int)!
        dateComponents.day = (dict["dayOfMonth"] as? Int)!
        dateComponents.timeZone = TimeZone(abbreviation: "BST") // EET, CET, BST Standard Time
        dateComponents.hour = (dict["hour"] as? Int)!
        dateComponents.minute = (dict["minute"] as? Int)!
        dateComponents.second = 0
        
        
        var calendar = Calendar(identifier: .iso8601)
        // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let someDateTime = calendar.date(from: dateComponents)
        print (Booking.formatDate(date: someDateTime!))
        return someDateTime!
    }
    
    static func fetch(data:Any) -> AnyObject{
        print ("fetching Payment")
    
        guard let dict = data as? [String : Any] else {return "" as AnyObject}
        let payment = Payment()
        
        payment.adminFee = dict["adminFee"] as? Double
        payment.confirmationNumber = dict["confirmationNumber"] as? String
        payment.courtCharge = dict["courtCharge"] as? Double
        print ("Payment Date time is \(dict["paymentDateTime"])" )
        payment.paymentDateTime = Payment.setDate(data: dict["paymentDateTime"])
        payment.paymentId = dict["paymentId"] as? Int
        payment.paymentMethod = dict["paymentMethod"] as? String
        payment.status = dict["status"] as? String
        payment.subTotal = dict["subTotal"] as? Double
        payment.taxAmount = dict["taxAmount"] as? Double
        payment.taxPercentage = dict["taxPercentage"] as? Double
        payment.totalAmount = dict["totalAmount"] as? Double
        
        return payment;
        
    }
    
    static func formatToCurrency(num:Double)->String
    {
        let formattedCurrency="\(String(format: "$%.02f", num))"
        return formattedCurrency
    }
    
    public func toString() -> String {
        var data = ""
        data += "paymentId: \(self.paymentId) "
        //data += "paymentDateTime: \(Booking.formatDate(date: self.paymentDateTime!)) "
        data += "courtCharge: \(Payment.formatToCurrency(num:  self.courtCharge!)) "
        data += "paymentMethod: \(self.paymentMethod) "
        data += "subTotal: \(Payment.formatToCurrency(num: self.subTotal!)) "
        data += "taxAmount: \(Payment.formatToCurrency(num:self.taxAmount!)) "
        data += "taxPercentage: \(self.taxPercentage) "
        data += "totalAmount: \(Payment.formatToCurrency(num: self.totalAmount!)) "
        data += "Status: \(self.status!) "
        
        return data
    }

}
