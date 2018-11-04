//
//  InvoiceDetailsViewController.swift
//  book2ball
//
//  Created by Xcode User on 2018-11-03.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

class InvoiceDetailsViewController: UIViewController {

    @IBOutlet weak var bookingDate: UILabel!
    @IBOutlet weak var bookingType: UILabel!
    @IBOutlet weak var startDateTime: UILabel!
    @IBOutlet weak var endDateTime: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var courtName: UILabel!
    @IBOutlet weak var facilityName: UILabel!
    @IBOutlet weak var paymentDateTime: UILabel!
    @IBOutlet weak var courtCharge: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
