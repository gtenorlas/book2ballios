//
//  RegistrationViewController.swift
//  Book2Ball
//
//  Created by Gene Tenorlas User on 2018-04-15.
//  Copyright © 2018 Xcode User. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var status: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password1: UITextField!
    @IBOutlet var password2: UITextField!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var contactNumber: UITextField!
    @IBOutlet weak var myImageView : UIImageView!
    
    @IBAction func uploadPhoto(_ sender: AnyObject){
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = true
        self.present(image, animated: true){
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.image = image
            myImageView.layer.cornerRadius = myImageView.frame.size.width/2
            myImageView.clipsToBounds = true
        }else{
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmitTap(_ sender: UIButton) {
        //check if fields are valid
        if (username.text == "" || password1.text == "" || password2.text == "" || firstName.text == "" || lastName.text == "" || email.text == "") {
            status.text = "All fields must be filled in."
        }else {
            if(password1.text != password2.text){
                status.text = "Password do not match."
            }
            else {
                if ((username.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (password1.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (password2.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (firstName.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (lastName.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (email.text?.trimmingCharacters(in: .whitespaces).isEmpty)!)
                {
                status.text = "No spaces please."
            }
            else {
                    if((username.text!.characters.count) > 20 || (password1.text!.characters.count) > 20  || (password2.text!.characters.count) > 20 || (firstName.text!.characters.count) > 20 || (lastName.text!.characters.count) > 20 || (email.text!.characters.count) > 20 || (username.text!.characters.count) < 8 || (password1.text!.characters.count) < 8  || (password2.text!.characters.count) < 8 || (firstName.text!.characters.count) < 8 || (lastName.text!.characters.count) < 8 || (email.text!.characters.count) < 8) {
                        status.text = "Number of charachters must be under 20."
                    }
                    else {
                //create a new user
                let user: Customer = Customer( username: username.text as! NSString, password: password1.text as! NSString, firstName: firstName.text as! NSString, lastName: lastName.text as! NSString, email: email.text as! NSString,contactNumber: contactNumber.text as! NSString, startDate: "10-22-2018-13-30" ,endDate: "null" , status: "Active", originate: "Standard")
                print(username.text)
                print(password1.text)
                print(firstName.text)
                print(lastName.text)
                let response = Customer.save(customer: user)
                        if response as? String == "success" {
                            //set the user is logged in
                            mainDelegate.userLoggedIn = user
                            //go to searchFacility
                            performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
                            
                        }else {
                            status.text = "Username already taken."
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
        
    }
    
}
