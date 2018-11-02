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
    @IBOutlet var lblCustomer : UILabel!
    @IBOutlet var lblFacility : UILabel!
    @IBOutlet var lblCourt : UILabel!
    @IBOutlet var lblDate : UILabel!
    @IBOutlet var lblTime : UILabel!
    @IBOutlet var lblHrs : UILabel!
    @IBOutlet var lblTax : UILabel!
    @IBOutlet var lblsubTot : UILabel!
    @IBOutlet var lblTotAmt : UILabel!
    @IBOutlet var lblFacCharge : UILabel!
    @IBOutlet var lblPayCnfm : UILabel!
    @IBOutlet var payButton: UIButton!
    
    //add button programmatically
    let button = UIButton(frame: CGRect(x:50, y: 150, width: 300, height: 30))
    
    func setValues(){
        lblCustomer.text = "\(mainDelegate.userLoggedIn.firstName) \(mainDelegate.userLoggedIn.lastName)"
        lblFacility.text = mainDelegate.payment.facility
        lblCourt.text = mainDelegate.payment.court
        lblDate.text = mainDelegate.payment.reservationDate
        lblTime.text = mainDelegate.payment.reservationStartTime
        lblHrs.text = mainDelegate.payment.numOfHours
        lblTax.text = "$" + mainDelegate.payment.tax!
        lblsubTot.text = "$" + mainDelegate.payment.subTotal!
        lblTotAmt.text = "$" + mainDelegate.payment.totalAmount!
        lblFacCharge.text = "$" + mainDelegate.payment.facilityCharge
        lblPayCnfm.text=""
        payButton.isEnabled=true
        
    }
    
    func updatePayCnfmLbl()
    {
        //let vol = slVolume.value.rounded();
        //let strVol = String(format: "%.0f",vol)
        lblPayCnfm.text = "Payment Successful!"
        payButton.isEnabled=false
        
        //save to database
        try! mainDelegate.dao.insertToTablePayment(payment: mainDelegate.payment)
        
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
        let item1 = PayPalItem(name: mainDelegate.payment.facility!, withQuantity: UInt(mainDelegate.payment.numOfHours!)!, withPrice: NSDecimalNumber(string: mainDelegate.payment.facilityCharge), withCurrency: "CAD", withSku: mainDelegate.payment.court)
        
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: mainDelegate.payment.tax)
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


