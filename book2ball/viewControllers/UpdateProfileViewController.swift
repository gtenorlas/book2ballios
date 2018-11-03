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
    
    var user: Customer = Customer()
    
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
        //check if fields are valid
        if (username.text == "" || password1.text == "" || password2.text == "" || firstName.text == "" || lastName.text == "" || email.text == "") {
            status.text = "All fields must be filled in."
            
        }else {
            if(password1.text != password2.text){
                status.text = "Password do not match."
            }else {
                /*
                if (try! mainDelegate.dao.readFromTableUserByUsername(username: username.text as! NSString) == true) {
                    //user already exist
                    status.text = "Username already taken."
                } else {
 */
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
               // }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        let response = Customer.fetch(customer: user)
        if let invalid = response as? String {
            print ("response is \(invalid)")
            status.text = "Username/password incorrect."
        }else {
            user = response as! Customer
            username.text = user.username as String
            print(username.text)
            firstName.text = user.firstName as String
            // lastName.text = user.lastName as String
            email.text = user.email as String
            contactNumber.text = user.contactNumber as String
            //performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
        }
        
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
