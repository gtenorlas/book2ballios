//
//  DAO.swift
//
//  Created by Shanu Shanu User on 2018-03-28.
//  Copyright © 2018 Xcode User. All rights reserved.
//
//  The purpose of this class is to do all the transactions to the database.
//  CRUD operation for all the data objects such as Payment, Court, Facility, Customer.
//  Create and drop tables.

import UIKit
import SQLite3
import Foundation

//create enum for throwing exception
//define  error messages
enum DBError: Error{
    case unableToOpen
    case unableToCreateTable
    case unableToDropTable
    case insertQueryFailed
    case unableToRetrieveData
}

class DAO: NSObject{
    public let databaseFileName = "magsdb.sqlite3"
    var db: OpaquePointer? = nil
    
    public override init(){
        
    }
    
    //copy the database from the project folder to the document's folder when db does not exists
    func copyDatabaseIfNeeded() {
        // Move database file from bundle to documents folder
        
        let fileManager = FileManager.default
        
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        
        guard documentsUrl.count != 0 else {
            return // Could not find documents URL
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent(self.databaseFileName)
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent(self.databaseFileName)
            
            do {
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
            
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
        
    }
    
    //open db
    func openDB() throws  {
       
        let dbPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(databaseFileName)
        
        print("DBPath \(dbPath)")
        
        //open db
        if sqlite3_open(dbPath.path, &db) != SQLITE_OK{
            throw DBError.unableToOpen //throw an error
        }else {
        print ("Database open \(databaseFileName)")
        }
    }
    
    //drop a specified table if it exists on the database
    func dropTable(tableName:String) throws{
        let dropTableQuery = "DROP TABLE IF EXISTS \(tableName)"
        //execute creating the table
        if sqlite3_exec(db, dropTableQuery, nil, nil, nil) != SQLITE_OK {
            throw DBError.unableToDropTable
        }else {
            print ("table dropped \(tableName)")
        }
        
    }
    
    //create the table for the facility
    func createTableFacility() throws {
        //only create table if not already created
        var createTableStatement: OpaquePointer? = nil
        let createTableQuery = "CREATE TABLE IF NOT EXISTS facility (id INTEGER PRIMARY KEY AUTOINCREMENT, facilityName TEXT, contactNumber TEXT, website TEXT, icon TEXT, address TEXT, city TEXT, creationDate DATE, endDate DATE);"
        
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("table facility created")
            }
            
        }else {
            throw DBError.unableToCreateTable
        }
        //close connection
        sqlite3_finalize(createTableStatement)
 
    }
    
    //Inserting Facility object to the facility table
    func insertToTableFacility(facilityToSave:FacilityData) throws{
        var insertPointer: OpaquePointer? = nil
        let insertQuery = "INSERT INTO facility ( facilityName, contactNumber, website, icon, address, city, creationDate, endDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
    
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertPointer, nil) == SQLITE_OK {
            
            
            print("facility to save: \(facilityToSave.id) \(facilityToSave.facilityName) \(facilityToSave.contactNumber) \(facilityToSave.website) \(facilityToSave.icon)  \(facilityToSave.address) \(facilityToSave.city) \(facilityToSave.creationDate) \(facilityToSave.endDate)")
            
            //UTF8STRING IS REQUIRED, ELSE value is not recored correctly
            sqlite3_bind_text(insertPointer, 1, facilityToSave.facilityName.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 2, facilityToSave.contactNumber.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 3, facilityToSave.website.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 4, facilityToSave.icon.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 5, facilityToSave.address.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 6, facilityToSave.city.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 7, facilityToSave.creationDate.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 8, facilityToSave.endDate.utf8String, -1, nil)
            
            //done saving successfully
            if sqlite3_step(insertPointer) == SQLITE_DONE {
                print ("facility Data saved.")
            }
        } else {
            print ("error inserting facility")
            DBError.insertQueryFailed
        }
        sqlite3_finalize(insertPointer) //close
    }
    
    //Read all the data from the facility table and return an array object
    func readFromTableFacilityAll() throws -> Array<FacilityData>{
        var facilities:Array<FacilityData> = []
        let query="SELECT * FROM facility;"
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            //loop each result
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                let id = sqlite3_column_int(stmt, 0)
                let facilityName = sqlite3_column_text(stmt, 1)
                let facilityNameString = String (cString: facilityName!)
                let contactNumber = sqlite3_column_text(stmt, 2)
                let contactNumberString = String(cString: contactNumber!)
                let website = sqlite3_column_text(stmt, 3)
                let websiteString = String(cString: website!)
                let icon = sqlite3_column_text(stmt, 4)
                let iconString = String(cString: icon!)
                let address = sqlite3_column_text(stmt, 5)
                let addressString = String(cString: address!)
                let city = sqlite3_column_text(stmt, 6)
                let cityString = String(cString: city!)
                let creationDate =  sqlite3_column_text(stmt, 7)
                let creationDateString = String(cString: creationDate!)
                let endDate =  sqlite3_column_text(stmt, 8)
                let endDateString = String(cString: endDate!)
                
                let idString = String(id)
                print("id " + idString)
                print("facilityname " + facilityNameString)
                print("contact Number " + contactNumberString)
                print("website " + websiteString)
                print("icon " + iconString)
                print("address " + addressString)
                print("city " + cityString)
                print("creation Date:" + creationDateString)
                print("end Date:" + endDateString)
                
                //add to array
                facilities.append(FacilityData(id: Int(id), facilityName: facilityNameString as NSString, contact: contactNumberString as NSString, website: websiteString as NSString, icon: iconString as NSString, address: addressString as NSString, city: cityString as NSString, creationDate: creationDateString as NSString, endDate: endDateString as NSString))
            }
        }else {
           DBError.unableToRetrieveData
        }
        sqlite3_finalize(stmt)//close
        return facilities
    }
    
    //Read the facility that belongs to a certain city.
    //This will call when the customer is searching a facility based off a city
    func readFromTableFacilityByCity(city: NSString) throws -> Array<FacilityData>{
        var facilities:Array<FacilityData> = []
        let query="SELECT * FROM facility where city = ?;"
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, city.utf8String, -1, nil)
            
            //loop each result
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                let id = sqlite3_column_int(stmt, 0)
                let facilityName = sqlite3_column_text(stmt, 1)
                let facilityNameString = String (cString: facilityName!)
                let contactNumber = sqlite3_column_text(stmt, 2)
                let contactNumberString = String(cString: contactNumber!)
                let website = sqlite3_column_text(stmt, 3)
                let websiteString = String(cString: website!)
                let icon = sqlite3_column_text(stmt, 4)
                let iconString = String(cString: icon!)
                let address = sqlite3_column_text(stmt, 5)
                let addressString = String(cString: address!)
                let city = sqlite3_column_text(stmt, 6)
                let cityString = String(cString: city!)
                let creationDate =  sqlite3_column_text(stmt, 7)
                let creationDateString = String(cString: creationDate!)
                let endDate =  sqlite3_column_text(stmt, 8)
                let endDateString = String(cString: endDate!)
                
                let idString = String(id)
                print("id " + idString)
                print("facilityname " + facilityNameString)
                print("contact Number " + contactNumberString)
                print("website " + websiteString)
                print("icon " + iconString)
                print("address " + addressString)
                print("city " + cityString)
                print("creation Date:" + creationDateString)
                print("end Date:" + endDateString)
                
                //add to array
                facilities.append(FacilityData(id: Int(id), facilityName: facilityNameString as NSString, contact: contactNumberString as NSString, website: websiteString as NSString, icon: iconString as NSString, address: addressString as NSString, city: cityString as NSString, creationDate: creationDateString as NSString, endDate: endDateString as NSString))
            }
        }else {
            DBError.unableToRetrieveData
        }
        sqlite3_finalize(stmt)//close
        return facilities
    }
    
    //This retrieve facility which belongs to a city and a name
    //This is mainly used when the customer selects a facility in the Facilities List Controller
    //And all related courts needs to be retrieved based off the facility returned
    func readFromTableFacilityByNameAndCity(name: NSString, city: NSString) throws -> Array<FacilityData>{
        var facilities:Array<FacilityData> = []
        let query="SELECT * FROM facility WHERE facilityName = ? AND city = ?;"
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, name.utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, city.utf8String, -1, nil)
            
            //loop each result
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                let id = sqlite3_column_int(stmt, 0)
                let facilityName = sqlite3_column_text(stmt, 1)
                let facilityNameString = String (cString: facilityName!)
                let contactNumber = sqlite3_column_text(stmt, 2)
                let contactNumberString = String(cString: contactNumber!)
                let website = sqlite3_column_text(stmt, 3)
                let websiteString = String(cString: website!)
                let icon = sqlite3_column_text(stmt, 4)
                let iconString = String(cString: icon!)
                let address = sqlite3_column_text(stmt, 5)
                let addressString = String(cString: address!)
                let city = sqlite3_column_text(stmt, 6)
                let cityString = String(cString: city!)
                let creationDate =  sqlite3_column_text(stmt, 7)
                let creationDateString = String(cString: creationDate!)
                let endDate =  sqlite3_column_text(stmt, 8)
                let endDateString = String(cString: endDate!)
                
                let idString = String(id)
                print("id " + idString)
                print("facilityname " + facilityNameString)
                print("contact Number " + contactNumberString)
                print("website " + websiteString)
                print("icon " + iconString)
                print("address " + addressString)
                print("city " + cityString)
                print("creation Date:" + creationDateString)
                print("end Date:" + endDateString)
                
                //add to array
                facilities.append(FacilityData(id: Int(id), facilityName: facilityNameString as NSString, contact: contactNumberString as NSString, website: websiteString as NSString, icon: iconString as NSString, address: addressString as NSString, city: cityString as NSString, creationDate: creationDateString as NSString, endDate: endDateString as NSString))
            }
        }else {
            DBError.unableToRetrieveData
        }
        sqlite3_finalize(stmt)//close
        return facilities
    }
    
    //Create a court table in the database
    func createTableCourt() throws {
        //only create table if not already created
        var createTableStatement: OpaquePointer? = nil
        
        //create court table with foreign key to id in the facility table
        let createTableQuery = "CREATE TABLE IF NOT EXISTS court (courtNumber INTEGER PRIMARY KEY AUTOINCREMENT, courtName TEXT,  availability TEXT, maxPlayer INTEGER, creationDate DATE, endDate DATE, facilityId INTEGER, FOREIGN KEY(facilityId) REFERENCES facility(id));"
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("Court table created")
            }
            
        }else {
            throw DBError.unableToCreateTable
        }
        sqlite3_finalize(createTableStatement)
        
    }
    
    //Insert a court in a court table
    func insertToTableCourt(courtToSave:Court) throws{
        var insertPointer: OpaquePointer? = nil
        let insertQuery = "INSERT INTO court ( courtName, availability, maxPlayer, creationDate,endDate, facilityId) VALUES (?,?,?,?,?,?);"
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertPointer, nil) == SQLITE_OK {
            
            
            print("court to save: \(courtToSave.courtNumber) \(courtToSave.courtName) \(courtToSave.availability) \(courtToSave.creationDate) \(courtToSave.endDate) \(courtToSave.maxPlayer)")
            
            //UTF8STRING IS REQUIRED, ELSE value is not recored correctly
            sqlite3_bind_text(insertPointer, 1, courtToSave.courtName.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 2, courtToSave.availability.utf8String, -1, nil)
            sqlite3_bind_int(insertPointer, 3, Int32(courtToSave.maxPlayer))
            sqlite3_bind_text(insertPointer, 4, courtToSave.creationDate.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 5, courtToSave.endDate.utf8String, -1, nil)
            sqlite3_bind_int(insertPointer, 6, Int32(courtToSave.facilityId))
            
            //done saving successfully
            if sqlite3_step(insertPointer) == SQLITE_DONE {
                print ("Court Data saved.")
            }
        } else {
            print ("error inserting")
            DBError.insertQueryFailed
        }
        sqlite3_finalize(insertPointer) //close
    }
    
    //Retrieve courts from the datbase belonging to a facility
    func readFromTableCourtByFacilityId(facilityId:Int) throws -> Array<Court>{
        var courts:Array<Court> = []
        let query="SELECT * FROM court where facilityId = ?;"
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            
            sqlite3_bind_int(stmt, 1, Int32(facilityId))
            
            //loop each result
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                let courtNumber = sqlite3_column_int(stmt, 0)
                let courtName = sqlite3_column_text(stmt, 1)
                let courtNameString = String (cString: courtName!)
                let availability = sqlite3_column_text(stmt, 2)
                let availabilityString = String(cString: availability!)
                let maxPlayer = sqlite3_column_int(stmt, 3)
                let creationDate =  sqlite3_column_text(stmt, 4)
                let creationDateString = String(cString: creationDate!)
                let endDate =  sqlite3_column_text(stmt, 5)
                let endDateString = String(cString: endDate!)
                let facilityId = sqlite3_column_int(stmt, 6)
                
                let idString = String(courtNumber)
                let maxPlayerString = String(maxPlayer)
                let facilityIdString = String(facilityId)
                print("Court Number " + idString)
                print("name " + courtNameString)
                print("availability " + availabilityString)
                print("maxPlayer " + maxPlayerString)
                print("creation Date:" + creationDateString)
                print("end Date:" + endDateString)
                print("facilityId:" + facilityIdString)
                
                //add to array
                courts.append(Court(id: Int(courtNumber), name: courtNameString as NSString, availability: availabilityString as NSString,player: Int(maxPlayerString)!, cDate: creationDateString as NSString, eDate: endDateString as NSString, facilityId: Int(facilityId)))
            }
        }else {
            DBError.unableToRetrieveData
        }
        sqlite3_finalize(stmt)//close
        return courts
    }
    
    //create a table user for new customers
    func createTableUser() throws {
        //only create table if not already created
        var createTableStatement: OpaquePointer? = nil
        let createTableQuery = "CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, firstName TEXT, lastName TEXT, email TEXT);"
       
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("table created")
            }
            
        }else {
            throw DBError.unableToCreateTable
        }
        sqlite3_finalize(createTableStatement)
        
    }
    
    //insert a new customer
    func insertToTableUser(userToSave:Customer) throws{
        var insertPointer: OpaquePointer? = nil
        let insertQuery = "INSERT INTO user ( username, password, firstName, lastName, email) VALUES (?, ?, ?, ?, ?);"
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertPointer, nil) == SQLITE_OK {
          //  print("user to save: \(userToSave.id) \(userToSave.username) \(userToSave.password) \(userToSave.email)")
            
            //UTF8STRING IS REQUIRED, ELSE value is not recorded correctly
            sqlite3_bind_text(insertPointer, 1, userToSave.username.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 2, userToSave.password.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 3, userToSave.firstName.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 4, userToSave.lastName.utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 5, userToSave.email.utf8String, -1, nil)
            
            //done saving successfully
            if sqlite3_step(insertPointer) == SQLITE_DONE {
                print ("User Customer Data saved.")
            }
        } else {
            print ("error inserting Customer")
            DBError.insertQueryFailed
        }
        sqlite3_finalize(insertPointer) //close
    }
    
   
    
    /*
     To grab the user that is trying to log in
    */
    func readFromTableUserByUsernameAndPassword(username:NSString, password:NSString) throws -> Array<Customer>{
        var users:Array<Customer> = []
        let query="SELECT * FROM user where username = ? and password = ?;"
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, username.utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, password.utf8String, -1, nil)
            //loop each result
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                let id = sqlite3_column_int(stmt, 0)
                let username = sqlite3_column_text(stmt, 1)
                let usernameString = String (cString: username!)
                let password = sqlite3_column_text(stmt, 2)
                let passwordString = String(cString: password!)
                let firstName =  sqlite3_column_text(stmt, 3)
                let firstNameString = String(cString: firstName!)
                let lastName =  sqlite3_column_text(stmt, 4)
                let lastNameString = String(cString: lastName!)
                let email =  sqlite3_column_text(stmt, 5)
                let emailString = String(cString: email!)
                
                let idString = String(id)
                print("id " + idString)
                print("username " + usernameString)
                print("password " + passwordString)
                print("firstName:" + firstNameString)
                print("lastName:" + lastNameString)
                print("email:" + emailString)
                
                //add to array
              //  users.append(Customer(id: Int(id), username: usernameString as NSString, password: passwordString as NSString, firstName: firstNameString as NSString, lastName: lastNameString as NSString, email: emailString as NSString))
            }
        }else {
            DBError.unableToRetrieveData
        }
        sqlite3_finalize(stmt)//close
        return users
    }
    
    /*
     To check if username already exist in the system when registering
     */
    func readFromTableUserByUsername(username:NSString) throws -> Bool{
        let query="SELECT * FROM user where username = ?;"
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1, username.utf8String, -1, nil)
   
            //loop each result
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                 sqlite3_finalize(stmt)//close
                return true;
            }
        }else {
            DBError.unableToRetrieveData
        }
        sqlite3_finalize(stmt)//close
        return false
    }
    
    //Create a payment table in the database
    func createTablePayment() throws {
        //only create table if not already created
        var createTableStatement: OpaquePointer? = nil
        let createTableQuery = "CREATE TABLE IF NOT EXISTS payment (id INTEGER PRIMARY KEY AUTOINCREMENT, facilityCharge TEXT, subTotal TEXT,  tax TEXT, facility TEXT, court TEXT, reservationDate text, reservationStartTime TEXT, numOfHours TEXT, totalAmount TEXT, customerEmail TEXT);"
        
        //execute creating the table
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("payment table created")
            }
            
        }else {
            throw DBError.unableToCreateTable
        }
        sqlite3_finalize(createTableStatement)
    }
    
    //insert a new payment to the payment table
    func insertToTablePayment(payment:Payment) throws{
        var insertPointer: OpaquePointer? = nil
        let insertQuery = "INSERT INTO payment (facilityCharge, subTotal, tax, facility, court, reservationDate, reservationStartTime, numOfHours, totalAmount, customerEmail) VALUES (?,?,?,?,?,?,?,?,?,?);"
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertPointer, nil) == SQLITE_OK {
            
            print("payment to save: \(payment.facilityCharge) \(payment.subTotal) \(payment.tax) \(payment.facility) \(payment.court) \(payment.reservationDate) \(payment.reservationStartTime) \(payment.numOfHours) \(payment.totalAmount) \(payment.customerEmail)")
            
            //UTF8STRING IS REQUIRED, ELSE value is not recored correctly
            sqlite3_bind_text(insertPointer, 1, (payment.facilityCharge as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 2, (payment.subTotal! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 3, (payment.tax! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 4, (payment.facility! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 5, (payment.court! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 6, (payment.reservationDate! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 7, (payment.reservationStartTime! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 8, (payment.numOfHours! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 9, (payment.totalAmount! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertPointer, 10, (payment.customerEmail! as NSString).utf8String, -1, nil)
            
            //done saving successfully
            if sqlite3_step(insertPointer) == SQLITE_DONE {
                print ("Data saved for payment.")
            }
        } else {
            print ("error inserting")
            DBError.insertQueryFailed
        }
        sqlite3_finalize(insertPointer) //close
    }
    
    //Get all the bookings that belongs the customer's email
    func readFromTablePaymentByEmail(email: String) throws -> Array<Payment>{
        var payments:Array<Payment> = []
        let query="SELECT * FROM payment where customerEmail = ?;"
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 1,  (email as NSString!).utf8String, -1, nil)
            
            //loop each result
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                let payment: Payment = Payment()
                
                let subtotal = sqlite3_column_text(stmt, 2)
                payment.subTotal = String (cString: subtotal!)
                let tax = sqlite3_column_text(stmt, 3)
                payment.tax = String (cString: tax!)
                let facility = sqlite3_column_text(stmt, 4)
                payment.facility = String (cString: facility!)
                let court = sqlite3_column_text(stmt, 5)
                payment.court = String (cString: court!)
                let reservationDate = sqlite3_column_text(stmt, 6)
                payment.reservationDate = String (cString: reservationDate!)
                let reservationStartTime = sqlite3_column_text(stmt, 7)
                payment.reservationStartTime = String (cString: reservationStartTime!)
                let numOfHours = sqlite3_column_text(stmt, 8)
                payment.numOfHours = String (cString: numOfHours!)
                let totalAmount = sqlite3_column_text(stmt, 9)
                payment.totalAmount = String (cString: totalAmount!)
                let customerEmail = sqlite3_column_text(stmt, 10)
                payment.customerEmail = String (cString: customerEmail!)
       
 
                print("facilityCharge " + payment.facilityCharge)
                print("subtotal " + payment.subTotal!)
                print("tax " + payment.tax!)
                print("facility " + payment.facility!)
                print("court " + payment.court!)
                print("reservation Date " + payment.reservationDate!)
                print("reservation start time " + payment.reservationStartTime!)
                print("number of hours " + payment.numOfHours!)
                print("total amount " + payment.totalAmount!)
                print("customer email " + payment.customerEmail!)
                
                //add to array
                payments.append(payment)
            }
        }else {
            DBError.unableToRetrieveData
        }
        sqlite3_finalize(stmt)//close
        return payments
    }
    /*
     Insert default data for facilities
    */
    func insertDefaultFacilities() throws{
        //TORONTO
        let toronto1: FacilityData = FacilityData()
        let toronto2: FacilityData = FacilityData()
        let toronto3: FacilityData = FacilityData()
        let toronto4: FacilityData = FacilityData()
        let toronto5: FacilityData = FacilityData()
        
        toronto1.id = 1
        toronto2.id = 2
        toronto3.id = 3
        toronto4.id = 4
        toronto5.id = 5
        
        toronto1.facilityName = "Totronto Pan Am"
        toronto2.facilityName = "Life Time Athletic"
        toronto3.facilityName = "Good Life Fitness"
        toronto4.facilityName = "York Recreation Centre"
        toronto5.facilityName = "Powerade Centre"
        
        toronto1.website = "https://www.tpasc.ca/"
        toronto2.website = "https://www.lifetime.life/life-time-locations/on-mississauga.html?selecteddate=2018-03-27"
        toronto3.website = "https://www.goodlifefitness.com/"
        toronto4.website = "https://www.toronto.ca/data/parks/prd/facilities/complex/3501/index.html"
        toronto5.website = "http://www.poweradecentre.com/"
        
        toronto1.icon = "torontoPan.png"
        toronto2.icon = "lifeTime.png"
        toronto3.icon = "goodLife.png"
        toronto4.icon = "york.png"
        toronto5.icon = "powerade.png"
        
        toronto1.address = "875 Morningside Ave, Toronto, Ontario, M1C0C7, Canada"
        toronto2.address = "7405 Weston Rd, Vaughan, Ontario, L4L0H3, Canada"
        toronto3.address = "3280 Bloor St W, Centre Tower 2nd Floor, Etobicoke, Ontario, M8X2X3, Canada"
        toronto4.address = "115 Black Creek Dr, Toronto, Ontario, M6A0A9, Canada"
        toronto5.address = "7575 Kennedy Rd S, Brampton, ON L6W 4T2"
        
        toronto1.city = "Toronto"
        toronto2.city = "Toronto"
        toronto3.city = "Toronto"
        toronto4.city = "Toronto"
        toronto5.city = "Toronto"
        
        
        //BRAMPTON
        let brampton1: FacilityData = FacilityData()
        let brampton2: FacilityData = FacilityData()
        
        brampton1.id = 6
        brampton2.id = 7
        
        brampton1.facilityName = "Life Time Athletic"
        brampton2.facilityName = "Good Life Fitness"
        
        brampton1.website = "https://www.lifetime.life/life-time-locations/on-mississauga.html?selecteddate=2018-03-27"
        brampton2.website = "https://www.goodlifefitness.com/"
        
        brampton1.icon = "lifeTime.png"
        brampton2.icon = "goodLife.png"
        
        brampton1.address = "7405 Weston Rd, Vaughan, Ontario, L4L0H3, Canada"
        brampton2.address = "11765 Bramalea Rd, Brampton, Ontario, L6R3S9, Canada"
        
        brampton1.city = "Brampton"
        brampton2.city = "Brampton"

        //Mississauga
        let mississauga1: FacilityData = FacilityData()
        
        mississauga1.id = 8
        mississauga1.facilityName = "Powerade Centre"
        mississauga1.website = "http://www.poweradecentre.com/"
        mississauga1.icon = "powerade.png"
        mississauga1.address = "7575 Kennedy Rd S, Brampton, Ontario, L6W4T2, Canada"
        mississauga1.city = "Mississauga"
        
        //save all to db
        try self.insertToTableFacility(facilityToSave: toronto1)
        try self.insertToTableFacility(facilityToSave: toronto2)
        try self.insertToTableFacility(facilityToSave: toronto3)
        try self.insertToTableFacility(facilityToSave: toronto4)
        try self.insertToTableFacility(facilityToSave: toronto5)
        try self.insertToTableFacility(facilityToSave: brampton1)
        try self.insertToTableFacility(facilityToSave: brampton2)
        try self.insertToTableFacility(facilityToSave: mississauga1)
        
    }
    
    /*
     Insert default data for courts
    */
    func insertDefaultCourts() throws{

        for index in 1...8 {
            print("Facility: \(index * 5)")
            let maxCourts: Int = (random(2..<6))
            for numCourt in 1..<maxCourts {
                let court:Court = Court()
                court.courtName = "Court #\(numCourt)" as NSString
                court.availability = "Available"
                court.maxPlayer = 10
                court.creationDate = "4/15/2018"
                court.endDate = ""
                court.facilityId = index
                try! self.insertToTableCourt(courtToSave: court) //save to db
            }
        }
    }
    
    //randomize a number
    func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
}

