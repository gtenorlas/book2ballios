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
    
    let facilityCharge: String = "123.25"
    var subTotal : String?
    var tax: String?
    var facility: String?
    var court: String?
    var reservationDate: String?
    var reservationStartTime:String?
    var numOfHours:String?
    var totalAmount:String?
    var customerEmail:String?
    
    override init (){
        
    }
    
    init (facility:String,court:String,resDate:String,resStart:String,numOfHours:String)
    {
        super.init()
        let numberFormatter = NumberFormatter()
        let xfacCharge = numberFormatter.number(from: facilityCharge)?.floatValue
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
    
    //calculate the amount owing without tax
    //based on facility charge * the amount of hours of rental
    func getSubTotal(facCharge:Float,hours:Float)->String
    {
        let sub=(facCharge * hours)
        let realValue=String(format: "%.2f", sub)
        return realValue
    }

}
