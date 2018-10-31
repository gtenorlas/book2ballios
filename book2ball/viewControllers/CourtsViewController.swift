//
//  CourtsViewController.swift
//  book2ball
//
//  Created by Admin on 2018-10-30.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

class CourtsViewController: UIViewController {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var listData:[String]=[]
    var descriptionData:[String]=[]
    var courts:Array<Court>=[]
    let numIncrement: Double = 0.5
    var duration: Double = 0
    var startDateTimeString = ""
    var endDateTimeString = ""
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBAction func indexChanged(sender:UISegmentedControl){
        print("# of Segments = \(sender.numberOfSegments)")
        duration = (Double(sender.selectedSegmentIndex)  + 1) * numIncrement
        print ("duration -> \(duration)")
    }
    
    @IBAction func onSearch(_ sender: UIButton){
        var formatterShort = DateFormatter()
        formatterShort.locale = Locale(identifier: "US_en")
        formatterShort.dateFormat = "E, dd MMM yyyy"
        let startDate = formatterShort.string(from: datePicker.date)
        
        formatterShort.dateFormat = "h:mm"
        let startTime = formatterShort.string(from: datePicker.date)
        
        print("StartDate: \(startDate), startTime: \(startTime)")
        
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        //local time zone by using .current
        calendar.timeZone = .current //TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.minute = Int(duration * 60)
        let endDateTime: Date = calendar.date(byAdding: components, to: datePicker.date)!
        
        formatterShort.dateFormat = "MM-dd-yyyy-h-mm"
        startDateTimeString=formatterShort.string(from:datePicker.date)
        endDateTimeString=formatterShort.string(from: endDateTime)
        print ("StartDateTime -> \(startDateTimeString), EndDateTime -> \(endDateTimeString)")
        courts = Court.fetch(facilityId: 1, startDateTime: startDateTimeString, endDateTime: endDateTimeString)
        print ("No of courts returned -> \(courts.count)")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
