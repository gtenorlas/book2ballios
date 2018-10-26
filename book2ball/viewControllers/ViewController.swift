//
//  ViewController.swift
//  book2ball
//
//  Created by moghid saad on 2018-10-08.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var passWord: UITextField!
    @IBOutlet var status: UILabel!
    
    //clear status text before performing a segue
    @IBAction func onFacebookClick(_ sender: UIButton) {
       status.text = ""
    }
    
    @IBAction func onGoogleClick(_ sender: UIButton) {
        status.text = ""
    }
    
    @IBAction func unwindToViewController(sender : UIStoryboardSegue)
    {
        
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
       // var users:Array<Customer>
        var users = Customer()
        users.username = userName.text as! NSString
        users.password = passWord.text as! NSString
        users.originate = "Standard"
        
        let response = Customer.fetch(customer: users)
        if let invalid = response as? String {
            print ("response is \(invalid)")
            status.text = "Username/password incorrect."
        }else {
            users = response as! Customer
            performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
        }

        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    


}

