//
//  CourtsViewController.swift
//  MAGS
//
//  Created by Admin on 2018-10-30.
//  Copyright © 2018 moghid saad. All rights reserved.
//
/*
 This Class is the view presented to the screen for prompting the user for the start date time and the duration. Upon click on the search, request is sent to the RESTful API to see all the courts available within the facility and the response are show in the screen for the user to select the desired court to book.
 */

import UIKit

class CourtsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var navImage : UIImageView!
    @IBOutlet var navBar : UINavigationBar!
    
    var willHideBook = true;
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var listData:[String]=[]
    var descriptionData:[String]=[]
    var courtTypeData: [String] = []
    var courts:Array<Court>=[]
    let numIncrement: Double = 0.5
    var duration: Int = 1
    var startDateTimeString = ""
    var endDateTimeString = ""
    var startDate = ""
    var startTime = ""
    var didSearch = false
    var didSelectDateTime = false
    var startDateTime : Date? = nil
    var endDateTime : Date? = nil
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95;
    }
    
    //define table method what to display on each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FacilityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellCardView") as? FacilityTableViewCell ?? FacilityTableViewCell(style: .default, reuseIdentifier: "cellCardView")
        
        cell.contentView.backgroundColor = UIColor (white: 0.90, alpha: 1)
        
        
        
        //populate the cell
        let rowNum = indexPath.row
        cell.select.backgroundColor = UIColor(red: 8.0/255, green: 104.0/255, blue: 244.0/255, alpha: 1.0)
        cell.select.isHidden = willHideBook
        cell.cellView.backgroundColor = UIColor(rgb: 0xFFFFFF)
        cell.facilityName.text = listData[rowNum]
        cell.facilityAddress.text = descriptionData[rowNum]
        cell.facilityDistance.text  = courtTypeData[rowNum]
        return cell
        
        
        /*
        let tableCell : CourtsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CourtsTableViewCell ?? CourtsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        //populate the cell
        let rowNum = indexPath.row
        let courtName = listData[rowNum]
        let description = descriptionData[rowNum]
        let arrowImage = UIImage(named: "arrow.jpeg")
        
        tableCell.primaryLabel.text = courtName
        tableCell.secondaryLabel.text = description
        tableCell.arrowImage.image = arrowImage
        tableCell.accessoryType = .none
        
        return tableCell
         */
    }
    
    //define the table method for clicking on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if didSearch == true && didSelectDateTime == true {
            
            mainDelegate.selectedCourt = courts[indexPath.row]
            
        let booking : Booking = Booking()
            booking.startDateTime = startDateTime
            booking.endDateTime = endDateTime
            booking.duration = duration
            mainDelegate.selectedBooking = booking
            
            let payment : Payment = Payment()
            payment.courtCharge = mainDelegate.selectedCourt.price
            payment.adminFee = 0.0
            payment.subTotal = payment.getSubTotalInDouble(facCharge: mainDelegate.selectedCourt.price, hours: duration)
            payment.taxPercentage = 13.00
            payment.setTaxAmount()
            print("$$$$$$$$$$$$$$$")
            print(payment.subTotal)
            print(payment.taxAmount)
            payment.totalAmount = payment.getTotalInDouble(subTot : payment.subTotal!, tax : payment.taxAmount!)
            payment.paymentDateTime = nil
            payment.confirmationNumber = nil
            payment.paymentMethod = "payPal"
            payment.status = ""
            mainDelegate.payment = payment
            
            
        
        performSegue(withIdentifier: "segueToPaypalViewController", sender: nil)
        }else {
            showAlert(alertString: "Please select Date/time, duration, and click on search.")
        }
    }
    

    
    @IBAction func indexChanged(sender:UISegmentedControl){
        print("# of Segments = \(sender.numberOfSegments)")
        duration = (Int(sender.selectedSegmentIndex)  + 1) //* numIncrement
        print ("duration -> \(duration)")
    }
    
    @IBAction func dateTimeChange(sender:UIDatePicker) {
        didSelectDateTime = true
        didSearch = false
    }
    
    @IBAction func onSearch(_ sender: UIButton){
        var formatterShort = DateFormatter()
        formatterShort.locale = Locale(identifier: "US_en")
        formatterShort.dateFormat = "E, dd MMM yyyy"
        startDate = formatterShort.string(from: datePicker.date)
        startDateTime = datePicker.date
        formatterShort.dateFormat = "h:mm"
        startTime = formatterShort.string(from: datePicker.date)
        
        print("StartDate: \(startDate), startTime: \(startTime)")
        
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        //local time zone by using .current
        calendar.timeZone = .current //TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.minute = Int(duration * 60)
        endDateTime = calendar.date(byAdding: components, to: datePicker.date)!
        
        formatterShort.dateFormat = "MM-dd-yyyy-HH-mm"
        startDateTimeString=formatterShort.string(from:datePicker.date)
        endDateTimeString=formatterShort.string(from: endDateTime!)
        print ("StartDateTime -> \(startDateTimeString), EndDateTime -> \(endDateTimeString)")
        courts = Court.fetch(facilityId: mainDelegate.selectedFacilityData.facilityId, startDateTime: startDateTimeString, endDateTime: endDateTimeString)
        print ("No of courts returned -> \(courts.count)")
        
        generateTableData(courtList: courts)
        didSearch = true
        willHideBook = false
        
        if courts.count == 0 {
            showAlert(alertString: "No available courts found with the selected date/time and duration")
        }
        
    }
    
    func generateTableData(courtList : Array<Court>){
        listData = []
        descriptionData = []
        courtTypeData = []
        for eachCourt:Court in courtList {
            //add to array
            listData.append(eachCourt.courtName as String)
            descriptionData.append("Max Players: \(eachCourt.maxPlayer)    Hourly Cost: $\(String(format:"%.2f", eachCourt.price))")
            courtTypeData.append("Court Type: \(eachCourt.courtType)")
        }
        myTableView.reloadData()
    }
    
    func showAlert(alertString: String) {
        let alert = UIAlertController(title: nil, message: alertString, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK",
                                     style: .cancel) { (alert) -> Void in
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        navImage.backgroundColor = UIColor(red: 1.0/255, green: 90.0/255, blue: 201.0/255, alpha: 1.0)
        navBar.barTintColor = UIColor(red: 1.0/255, green: 90.0/255, blue: 201.0/255, alpha: 1.0)
 
        
        segment.selectedSegmentIndex = 0;
        self.indexChanged(sender: segment)
        //change the min and max for date/time in the datepicker
        //5 hours fron the current time for min
        //14 days from the current date/time for max
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        //local time zone by using .current
        calendar.timeZone = .current //TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.hour = 2
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.day = 30
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        
        datePicker.minimumDate = minDate
        datePicker.maximumDate =  maxDate
      //  datePicker.minuteInterval = 0
        
        
        //table
        generateTableData(courtList: mainDelegate.selectedFacilityData.courtsList)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToCourtsViewController(sender : UIStoryboardSegue)
    {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
