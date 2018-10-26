//
//  BookingsViewController.swift
//  Book2Ball
//
//  Created by Gene Tenorlas User on 2018-04-19.
//  Copyright © 2018 Xcode User. All rights reserved.
//

import UIKit

class BookingsViewController: UIViewController , UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var navBar: UINavigationBar!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var listData:[String]=[]
    var descriptionData:[String]=[]
    var timeData: Array<String> = []
    
    var bookings:Array<Payment> = []
    
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
        
        navBar.topItem?.title = "\(mainDelegate.userLoggedIn.firstName) \(mainDelegate.userLoggedIn.lastName) Bookings"
        
        
        //get all the bookings
        bookings = try! mainDelegate.dao.readFromTablePaymentByEmail(email: mainDelegate.userLoggedIn.email as String)
        
        for each:Payment in bookings{
            //add to array
            listData.append(each.reservationDate!)
            descriptionData.append("Facility: \(each.facility!), Court: \(each.court!)")
            timeData.append("Time: \(each.reservationStartTime!), # of Hours: \(each.numOfHours!) ")
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
