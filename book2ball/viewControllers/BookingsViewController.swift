//
//  BookingsViewController.swift
//  MAGS
//
//  Created by Gene Tenorlas User on 2018-10-19.
//  Copyright © 2018 Xcode User. All rights reserved.
//
/*
 This Class is the view presented to the screen for displaying all the fetched bookings from the remote database for the logged in user.
 */

import UIKit

class BookingsViewController: UIViewController , UITableViewDataSource,UITableViewDelegate{
   
    @IBOutlet weak var menuButton : UIBarButtonItem!
    @IBOutlet weak var myTable : UITableView!
    @IBOutlet weak var statusCheck: UISegmentedControl!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
   var listData:[String]=[]
    var bookings:Array<Booking>=[]
    var viewingBookings:Array<Booking>=[]
    var descriptionData:[String]=[]
    var timeData: Array<String> = []
    var endTimeData: Array<String> = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("list data count \(listData.count)")
        
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124;
    }
    
    @IBAction func viewBookingsByType (_ sender: Any)
    {
        bookings = Booking.fetchByEmail(email: mainDelegate.userLoggedIn.email as String)
        self.viewingBookings = []
        listData = []
        descriptionData = []
        timeData = []
        endTimeData = []
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        
        let indexSelected = statusCheck.selectedSegmentIndex
        
        self.bookings.sort(by: self.sorterForFacilityDistanceASC)
        
        switch (indexSelected) {
        case 0:
            
            for each:Booking in bookings{
                //add to array
                print ("In for loop")
                print(each.status)
                if each.status == "Active" {
                    var bookDate = each.bookingDate
                    bookDate = formatter.date(from: myString)
                    formatter.dateFormat = "dd-MMM-yyyy"
                    let str = each.facilityName
                    listData.append("\(each.facilityName!)/\(each.courtName!)")
                    descriptionData.append("Number of Hours: \(each.duration!)")
                    
                    timeData.append("Start: \(Booking.formatDate(date: each.startDateTime!))")
                        endTimeData.append("End: \(Booking.formatDate(date: each.endDateTime!))")
                    viewingBookings.append(each)
                    print (  each.facilityName,each.startDateTime)
                }
                
            }
        case 1:
            
            for each:Booking in bookings{
                //add to array
                print ("In for loop")
                if each.status != "Active" {
                    var bookDate = each.bookingDate
                    bookDate = formatter.date(from: myString)
                    formatter.dateFormat = "dd-MMM-yyyy"
                    let str = each.facilityName
                    listData.append("\(each.facilityName!)/\(each.courtName!)")
                    descriptionData.append("Number of Hours: \(each.duration!)")
                    timeData.append("Start: \(Booking.formatDate(date: each.startDateTime!))")
                    endTimeData.append("End: \(Booking.formatDate(date: each.endDateTime!))")
                    viewingBookings.append(each)
                }
            }
        default:
            print("nothing to show")
        }
        
        myTable.reloadData()
    }
    
    func sorterForFacilityDistanceASC(this:Booking, that:Booking) -> Bool {
        return this.startDateTime! < that.startDateTime!
    }
    
    @IBAction func unwindToBookingsViewController(sender : UIStoryboardSegue)
    {
         myTable.reloadData()
    }
    
    // step 10 - define table method for how each cell should look
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BookingsCardViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BookingsCardViewTableViewCell") as? BookingsCardViewTableViewCell ?? BookingsCardViewTableViewCell(style: .default, reuseIdentifier: "BookingsCardViewTableViewCell")
        
        cell.contentView.backgroundColor = UIColor (white: 0.90, alpha: 1)
        
  
        
        let rowNum = indexPath.row
        
        cell.select.backgroundColor = UIColor(red: 8.0/255, green: 104.0/255, blue: 244.0/255, alpha: 1.0)
        cell.cellView.backgroundColor = UIColor(rgb: 0xFFFFFF)
        cell.facilityName.text = listData[rowNum] //.facilityName
        cell.duration.text = descriptionData[rowNum]
        cell.start.text = timeData[rowNum]
        cell.end.text = endTimeData[rowNum]
        return cell
        
        
        /*
        // step 10b - define PaymenTableViewCell.swift as UITableViewCell and move there before continuing
        // step 12 - check if cells already defined and a cell is leaving the screen.
        // if it is a newlyloaded view, cell will be instantiated.
        let tableCell : PaymentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PaymentTableViewCell ?? PaymentTableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        // step 12b - populate the cell
        let rowNum = indexPath.row
        let title = listData[rowNum]//.facilityName
        let description = descriptionData[rowNum]
        let timeHours = timeData[rowNum]
        let endTimeHours = endTimeData[rowNum]
        
        tableCell.primaryLabel.text =  title //as! String
        tableCell.secondaryLabel.text = description
        tableCell.thirdLabel.text = timeHours
         tableCell.fourthLabel.text = endTimeHours
        tableCell.accessoryType = .none
        
        // step 12c - return the cell
        return tableCell
        */
        
    }
    
    
    // step 9 making cells editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainDelegate.selectedBooking = viewingBookings[indexPath.row]
        print(indexPath.row)
        print (mainDelegate.selectedBooking.toString())
        performSegue(withIdentifier: "segueInvoiceDetailsViewController", sender: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        bookings = Booking.fetchByEmail(email: mainDelegate.userLoggedIn.email as String)
        statusCheck.selectedSegmentIndex = 0;
        self.viewBookingsByType(statusCheck)
        sideMenu()
        navigationController?.navigationBar.tintColor = UIColor(red: 1.0/255, green: 90.0/255, blue: 201.0/255, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red: 1.0/255, green: 90.0/255, blue: 201.0/255, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor : UIColor.white]
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
