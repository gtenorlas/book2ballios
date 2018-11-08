//
//  InvoiceDetailsViewController.swift
//  MAGS
//
//  Created by Xcode User on 2018-11-03.
//  Copyright © 2018 Gene Tenorlas. All rights reserved.
//

import UIKit

class InvoiceDetailsViewController: UIViewController {

    
    @IBOutlet weak var facilityName: UILabel!
    @IBOutlet weak var facilityAddress: UILabel!
    @IBOutlet weak var courtName: UILabel!
    @IBOutlet weak var startDateTime: UILabel!
    @IBOutlet weak var endDateTime: UILabel!
    @IBOutlet weak var paymentDateTime: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var courtCharge: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var taxPercentage: UILabel!
    @IBOutlet weak var taxAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let booking = mainDelegate.selectedBooking
        

  
        facilityName.text = mainDelegate.selectedBooking.facilityName as! String

        courtName.text = mainDelegate.selectedBooking.courtName as! String
        
        // again convert your date to string
        startDateTime.text = Booking.formatDate(date: booking.startDateTime!)
        endDateTime.text = Booking.formatDate(date: booking.endDateTime!)
        status.text =  booking.status as! String
         facilityAddress.text = booking.facilityAddress as! String
        
        if let payment = booking.payment as? Payment{
        
            paymentDateTime.text = Booking.formatDate(date: (payment.paymentDateTime!))
            courtCharge.text = Payment.formatToCurrency(num:  (payment.courtCharge)!)
           
            duration.text = "\(mainDelegate.selectedBooking.duration!)"
            subTotal.text = Payment.formatToCurrency(num:  (mainDelegate.selectedBooking.payment?.subTotal)!)
            taxPercentage.text = "\(String(format:"%.2f", (mainDelegate.selectedBooking.payment?.taxPercentage)!)) %"
            taxAmount.text = Payment.formatToCurrency(num: (mainDelegate.selectedBooking.payment?.taxAmount)!)
            totalAmount.text = Payment.formatToCurrency(num:  (mainDelegate.selectedBooking.payment?.totalAmount)!)
        }

        // Do any additional setup after loading the view.
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
