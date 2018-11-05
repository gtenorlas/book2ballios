//
//  PaypalViewController.swift
//  Book2Ball
//
//  Created by Chathu Anthony User on 2018-04-16.
//  Copyright © 2018 Xcode User. All rights reserved.
//

import UIKit

class PaypalViewController: UIViewController, PayPalPaymentDelegate {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var courtCharge : UILabel!
    @IBOutlet var adminFee : UILabel!
    @IBOutlet var subTotal : UILabel!
    @IBOutlet var taxPercentage : UILabel!
    @IBOutlet var taxAmount : UILabel!
    @IBOutlet var totalAmount : UILabel!
    @IBOutlet var paymentDateTime : UILabel!
    @IBOutlet var confirmationNumber : UILabel!
    @IBOutlet var paymentMethod : UILabel!
    @IBOutlet var status : UILabel!
    @IBOutlet var lblPayCnfm : UILabel!
    @IBOutlet var payButton: UIButton!
    
    //add button programmatically
    let button = UIButton(frame: CGRect(x:50, y: 150, width: 300, height: 30))
    
    func setValues(){
        courtCharge.text = String(format:"%.1f", mainDelegate.selectedCourt.price)
        adminFee.text = "0.0"
        subTotal.text = String(format:"%.1f", mainDelegate.payment.subTotal!)
        taxPercentage.text = String(format:"%.1f", mainDelegate.payment.taxPercentage!)
        taxAmount.text = String(format:"%.1f", mainDelegate.payment.taxAmount!)
        totalAmount.text = String(format:"%.1f", mainDelegate.payment.totalAmount!)
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
         mainDelegate.payment.paymentDateTime = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        paymentDateTime.text = formatter.string(from: mainDelegate.payment.paymentDateTime!)
        
        confirmationNumber.text =  ""
        paymentMethod.text =  mainDelegate.payment.paymentMethod!
        status.text =  "Completed"
        mainDelegate.payment.status = "Completed"
        lblPayCnfm.text=""
        payButton.isEnabled=true
        
    }
    
    func updatePayCnfmLbl()
    {
        //let vol = slVolume.value.rounded();
        //let strVol = String(format: "%.0f",vol)
        lblPayCnfm.text = "Payment Successful!"
        payButton.isEnabled=false
    
        var user = mainDelegate.userLoggedIn
        var facility = mainDelegate.selectedFacilityData
        var court = mainDelegate.selectedCourt
         var booking = mainDelegate.selectedBooking
        var payment = mainDelegate.payment
        
        
        let book: Booking = Booking(customerEmail: user.email  ,customerName: ((user.firstName as String) + (user.lastName as String)) as String as NSString, bookingType: "basketball", status: "Active", startDateTime: booking.startDateTime! , endDateTime: booking.endDateTime!, duration: booking.duration! , court: court , comment : "null" , payment : payment , facilityName : facility.facilityName, courtName: mainDelegate.selectedCourt.courtName)
        
        let id =  Booking.save(booking: book)
        if let respose = id as? String {
            let i=Int(respose)
            book.bookingId = i
            
        }
        
        print("Booking is : \(book.bookingId!)")
        /*
        let pay: Payment = Payment( booking: book, courtCharge: (courtCharge.text as? Double)!, adminFee: (adminFee.text as? Double)!, subTotal: (subTotal.text as? Double)!, taxPercentage: (taxPercentage.text as? Double)!, taxAmount: (taxAmount.text as?  Double)!, totalAmount: (totalAmount.text as? Double)!, paymentDateTime: (paymentDateTime.text as?  Date)!, confirmationNumber: confirmationNumber.text as! String, paymentMethod: paymentMethod.text as! String, status : status.text as! String)
       
        */
       payment.booking = book
        mainDelegate.payment = payment
        Payment.save(payment: mainDelegate.payment)
        
        //set the user is logged in
       // mainDelegate.payment = pay

        
        performSegue(withIdentifier: "bookingsViewControllerSegue", sender: nil)
        /*
        //add button
        button.backgroundColor = .gray
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("View My Bookings", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //bottom of the screen and centered
        button.frame.origin = CGPoint(x:self.view.frame.size.width / 2 - 150, y:self.view.frame.size.height - 40)
        //add to the view
        self.view.addSubview(button)
         */
    }
    
    //go to bookings view controller
    @objc func buttonAction(sender: UIButton!){
        performSegue(withIdentifier: "bookingsViewControllerSegue", sender: nil)
    }
    
    func setupPayPal(){
        // Do any additional setup after loading the view, typically from a nib.
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Book 2 Ball, Inc."
        
        //following urls are paypal merchant policies
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        //language used by the payPal sdk for the user. Default language is indicated by 0.
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        //customer can add a different address than the one in the payPal account
        payPalConfig.payPalShippingAddressOption = .both;
    }
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        //resultText = ""
        //successView.isHidden = true
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            
            //self.resultText = completedPayment.description
            //self.showSuccess()
        })
        updatePayCnfmLbl()
    }
    
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var payPalConfig = PayPalConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
        setupPayPal()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func paymentInitiation(_ sender: Any) {
        
        let Charge = String(format:"%.1f", mainDelegate.payment.courtCharge!)
        
        let item1 = PayPalItem(name: mainDelegate.selectedFacilityData.facilityName as String, withQuantity: UInt(mainDelegate.selectedBooking.duration!), withPrice: NSDecimalNumber(string : Charge), withCurrency: "CAD", withSku: mainDelegate.selectedCourt.courtName as String)
        
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let taxTotal = String(format:"%.1f", mainDelegate.payment.taxAmount!)
        let tax =  NSDecimalNumber(string : taxTotal)
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        
        //let total = subtotal.adding(shipping).adding(tax)
        let total = subtotal.adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "CAD", shortDescription: "Book 2 Ball", intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }
    }
    
}


