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
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
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
        var users:Array<Customer>
        do{
            try users = mainDelegate.dao.readFromTableUserByUsernameAndPassword(username: username.text as! NSString, password: password.text! as NSString)
            
            //no user exists
            if (users.count == 0) {
                status.text = "Username/password incorrect."
            }else {
                //user found with valid credentials
                //set the user is logged in
                mainDelegate.userLoggedIn = users[0]
                
                performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
            }
        }catch{
            print("Error retrieving user logging in")
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

