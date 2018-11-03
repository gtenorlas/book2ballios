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
            }else {
                
                
                status.text = "success"
                
                //create a new user
                let user: Customer = Customer( username: username.text as! NSString, password: password1.text as! NSString, firstName: firstName.text as! NSString, lastName: lastName.text as! NSString, email: email.text as! NSString,contactNumber: contactNumber.text as! NSString, startDate: "10-22-2018-13-30" ,endDate: "null" , status: "Active", originate: "Standard")
                print(username.text)
                print(password1.text)
                print(firstName.text)
                print(lastName.text)
                Customer.save(customer: user)
                
                //set the user is logged in
                mainDelegate.userLoggedIn = user
                
                //go to searchFacility
                performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
                
                /*
                
                if (try! mainDelegate.dao.readFromTableUserByUsername(username: username.text as! NSString) == true) {
                    //user already exist
                    status.text = "Username already taken."
                } else {
                    status.text = "success"
                    
                    //create a new user
                    let user: Customer = Customer( username: username.text as! NSString, password: password1.text as! NSString, firstName: firstName.text as! NSString, lastName: lastName.text as! NSString, email: email.text as! NSString,contactNumber: contactNumber.text as! NSString, startDate: "10-22-2018-13-30" ,endDate: "null" , status: "Active", originate: "Standard")
                    print(username.text)
                    print(password1.text)
                    print(firstName.text)
                    print(lastName.text)
                    Customer.save(customer: user)
                    
                    //set the user is logged in
                    mainDelegate.userLoggedIn = user
                    
                    //go to searchFacility
                    performSegue(withIdentifier: "searchFacilitySegue", sender: nil)

                }
  */
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
