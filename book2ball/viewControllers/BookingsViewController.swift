//
//  BookingsViewController.swift
//  Book2Ball
//
//  Created by Gene Tenorlas User on 2018-04-19.
//  Copyright © 2018 Xcode User. All rights reserved.
//

import UIKit

class BookingsViewController: UIViewController , UITableViewDataSource,UITableViewDelegate{
   // @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var menuButton : UIBarButtonItem!
    @IBOutlet weak var myTable : UITableView!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var listData:[String]=[]
    var descriptionData:[String]=[]
    var timeData: Array<String> = []
    
   // var bookings:Array<Payment> = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("list data count \(listData.count)")
        
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    
    @IBAction func unwindToBookingsViewController(sender : UIStoryboardSegue)
    {
        
    }
    
    // step 10 - define table method for how each cell should look
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // step 10b - define PaymenTableViewCell.swift as UITableViewCell and move there before continuing
        // step 12 - check if cells already defined and a cell is leaving the screen.
        // if it is a newlyloaded view, cell will be instantiated.
        let tableCell : PaymentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PaymentTableViewCell ?? PaymentTableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        // step 12b - populate the cell
        let rowNum = indexPath.row
        let title = listData[rowNum]
        let description = descriptionData[rowNum]
        let timeHours = timeData[rowNum]
        
        tableCell.primaryLabel.text =  title
        tableCell.secondaryLabel.text = description
        tableCell.thirdLabel.text = timeHours
        tableCell.accessoryType = .none
        
        // step 12c - return the cell
        return tableCell
        
    }
    
    
    // step 9 making cells editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // navBar.topItem?.title = "\(mainDelegate.userLoggedIn.firstName) \(mainDelegate.userLoggedIn.lastName) Bookings"
        
        
        //get all the bookings
        
      //  bookings = try! mainDelegate.dao.readFromTablePaymentByEmail(email: mainDelegate.userLoggedIn.email as String)
        /*
        var users = Customer()
        
        let response = Customer.fetch(customer: users)
        if let invalid = response as? String {
            print ("response is \(invalid)")
            status.text = "Username/password incorrect."
        }else {
            users = response as! Customer
            performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
        }
         
         var bookings : Array<Booking> = []
 */
         //= mainDelegate.userLoggedIn.email
        let book = Booking()
        book.customerEmail = mainDelegate.userLoggedIn.email
        let response = Booking.fetch(booking: book)
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
       // let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
       // formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
       // let myStringafd = formatter.string(from: yourDate!)
        
        //print(myStringafd)
        
        if let invalid = response as? String {
            print ("response is \(invalid)")
        }else {
        //var bookings = response as? Array<Booking>
            print ("running")
           // let responseArray = response []
           // users = response as! Customer
            /*
            for each:Booking in [response] as! Array<Booking> {
            //add to array
            print ("In for loop")
            var bookDate = each.bookingDate
            bookDate = formatter.date(from: myString)
            formatter.dateFormat = "dd-MMM-yyyy"
            let myStringafd = formatter.string(from: bookDate!)
            listData.append(myStringafd)
            
            descriptionData.append("Facility: \(each.facilityName!), Court: \(each.startDateTime!)")
            
            timeData.append("Time: \(each.duration!), # of Hours: \(each.endDateTime!) ")
 
            } */
        }
        sideMenu()
        
    }
    
    func sideMenu(){
        
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 250
            revealViewController().rightViewRevealWidth = 160
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
