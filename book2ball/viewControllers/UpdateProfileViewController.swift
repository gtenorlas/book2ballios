//
//  UpdateProfileViewController.swift
//  book2ball
//
//  Created by Xcode User on 2018-11-01.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var menuButton : UIBarButtonItem!
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
    
    var userLoggedIn: Customer = Customer()
    
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
    
    @IBAction func onUpdateTap(_ sender: UIButton) {
        print ("onupdateTap")
        //check if fields are valid
        if (username.text == "" || password1.text == "" || password2.text == "" || firstName.text == "" || lastName.text == "" || email.text == "") {
            status.text = "All fields must be filled in."
            
        }else {
            if(password1.text != password2.text){
                status.text = "Password do not match."
            }else {
                if((password1.text!.characters.count) > 20  || (password2.text!.characters.count) > 20 || (password1.text!.characters.count) < 8  || (password2.text!.characters.count) < 8) {
                    status.text = "Password fields must be >=8 and <=20"
                }
                else {
                    //create a new user
                    let user: Customer = Customer( username: username.text as! NSString, password: password1.text as! NSString, firstName: firstName.text as! NSString, lastName: lastName.text as! NSString, email: email.text as! NSString,contactNumber: contactNumber.text as! NSString, startDate: "10-22-2018-13-30" ,endDate: "null" , status: "Active", originate: mainDelegate.userLoggedIn.originate)
                    print(username.text)
                    print(password1.text)
                    print(firstName.text)
                    print(lastName.text)
                    let response = Customer.saveUpdatedProfile(customer: user)
                    if response as? String == "success" {
                        //set the user is logged in
                        mainDelegate.userLoggedIn = user
                        //go to searchFacility
                        performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
                        
                    }else {
                        status.text = "Username/email already taken."
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = UIColor(red: 54.0/255, green: 116.0/255, blue: 216.0/255, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red: 54.0/255, green: 116.0/255, blue: 216.0/255, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedStringKey.foregroundColor : UIColor.white]
        
     
        userLoggedIn = mainDelegate.userLoggedIn
        
            username.text = userLoggedIn.username as String

            firstName.text = userLoggedIn.firstName as String
            lastName.text = userLoggedIn.lastName as String
            email.text = userLoggedIn.email as String
            contactNumber.text = userLoggedIn.contactNumber as String
     
        
    }
    
    func sideMenu(){
        
        if revealViewController() != nil{
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 250
            revealViewController().rightViewRevealWidth = 160
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
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
