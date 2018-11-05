//
//  ViewController.swift
//  book2ball
//
//  Created by moghid saad on 2018-10-08.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var passWord: UITextField!
    @IBOutlet var status: UILabel!
    
    var users = Customer()
    
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
        
        users.username = userName.text as! NSString
        users.password = passWord.text as! NSString
        users.originate = "Standard"
        
        let response = Customer.fetch(customer: users)
        if let invalid = response as? String {
            print ("response is \(invalid)")
            status.text = "Username/password incorrect."
        }else {
            users = response as! Customer
            mainDelegate.userLoggedIn = users
            performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
        }

        
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        var resetEmail = ""
        let forgotPasswordAlert = UIAlertController(title: "Forgot password?", message: "Enter email address", preferredStyle: .alert)
        forgotPasswordAlert.addTextField { (textField) in
            textField.placeholder = "Enter email address"
        }
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { (action) in
            resetEmail = (forgotPasswordAlert.textFields?.first?.text)!
            let response = Customer.sendToken(email: resetEmail)
          //  Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                if response as? String == "invalid" {
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: (response as AnyObject).localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }else {
                    let resetEmailSentAlert = UIAlertController(title: "Enter the Token Number", message: "Check your email", preferredStyle: .alert)
                    resetEmailSentAlert.addTextField{ (textField) in
                        textField.placeholder = "Enter the Token Number"
                    }
                    resetEmailSentAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        let tokenNumber = resetEmailSentAlert.textFields?.first?.text
                        let response = Customer.validateToken(email: resetEmail, tokenToValidate: tokenNumber)
                        if response as? String == "invalid" {
                            let tokanFailedAlert = UIAlertController(title: "Invalid Token Number", message: "Error: \(String(describing: (response as AnyObject).localizedDescription))", preferredStyle: .alert)
                            tokanFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(tokanFailedAlert, animated: true, completion: nil)
                        }
                        else {
                            let resetPasswordAlert = UIAlertController(title: "Enter the Password", message: "Reset paswword", preferredStyle: .alert)
                            var password1 = ""
                            resetPasswordAlert.addTextField{ (textField1) in
                                textField1.placeholder = "Enter the password"
                                textField1.isSecureTextEntry = true
                                password1 = textField1.text!
                            }
                            var password2 = ""
                            resetPasswordAlert.addTextField{ (textField2) in
                                textField2.placeholder = "Confirm the password"
                                textField2.isSecureTextEntry = true
                                password2 = textField2.text!
                            }
                            //resetPasswordAlert.addTextField(configurationHandler: password1)
                            resetPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                            resetPasswordAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                // password1 = resetPasswordAlert.textFields?.first?.text
                               // let password2 = resetPasswordAlert.textFields?.first?.text
                                if password1 != password2 {
                                    let passwordNotMatched = UIAlertController(title: "Password must be the same", message: "Error: \(String(describing: (response as AnyObject).localizedDescription))", preferredStyle: .alert)
                                    passwordNotMatched.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(passwordNotMatched, animated: true, completion: nil)
                                    
                                }
                                else{
                                    if response as? String == "invalid" {
                                        let passwordFailedAlert = UIAlertController(title: "Failed to reset the password", message: "Error: \(String(describing: (response as AnyObject).localizedDescription))", preferredStyle: .alert)
                                        passwordFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                        self.present(passwordFailedAlert, animated: true, completion: nil)
                                    }
                                    else{
                                        let passwordAlert = UIAlertController(title: "Reset Done", message: "Password reset successfully", preferredStyle: .alert)

                                        passwordAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                        self.present(passwordAlert, animated: true, completion: nil)
                                        
                                    }
                                    
                                }
                                }))
                            
                            self.present(resetPasswordAlert, animated: true, completion: nil)
                        }
                        
                    }))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            
        }))
        //PRESENT ALERT
        self.present(forgotPasswordAlert, animated: true, completion: nil)
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    


}

