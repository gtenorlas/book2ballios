//
//  FacebookViewController.swift
//  MAGS
//
//  Created by Shanu Shanu User on 2018-10-15.
//  Copyright © 2018 Xcode User. All rights reserved.
//
/*
 This class is for the user to log in using Google. All the delegations are happening here to handle
 of prompting the user Google login and fetching the user information data.
 */

import UIKit
import FBSDKLoginKit

class FacebookViewController: UIViewController, FBSDKLoginButtonDelegate {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var lblStatus: UILabel!
    let button = UIButton(frame: CGRect(x:50, y: 150, width: 300, height: 30))
    
    var fb: FaceBookRegistration = FaceBookRegistration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let btnFBLogin = FBSDKLoginButton()
        btnFBLogin.readPermissions = ["public_profile", "email"]
        btnFBLogin.delegate = self
        
        btnFBLogin.center = self.view.center
        self.view.addSubview(btnFBLogin) //add the fb button on screen
        
        //check if user already logged in to fb
        if FBSDKAccessToken.current() != nil {
            lblStatus.text = "Already Logged In"
            fetchProfile()
        }else {
            lblStatus.text = "Please Login to Facebook"
        }
        
        
    }
    
    //go to search facility view controller
    //user already logged in to fb, allow user to proceed to the SearchFacilityViewController
    @objc func buttonAction(sender: UIButton!){
        performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //check for login error
        if error != nil {
            lblStatus.text = error.localizedDescription
        }else if result.isCancelled{
            lblStatus.text = "User cancelled"
        }else{
            //login success
            lblStatus.text = "User logged in"
            fetchProfile()
        }
        
    }
    
    //fb logged out
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        lblStatus.text = "User logged out"
        mainDelegate.userLoggedIn = Customer() //take out the person logged in
        button.removeFromSuperview() //remove the continue button
        sleep(2)
        performSegue(withIdentifier: "unwindToHomeSegue", sender: nil)
    }
    
    func fetchProfile(){
        print("fetch profile")
        
        mainDelegate.userLoggedIn = fb.fetchProfile()
        
        //add a button to continue to search facility
        
        button.backgroundColor = .gray
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Continue To Search Facility", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.center.x = self.view.frame.midX //center horizontally
        self.view.addSubview(button)
    }
    
    
    
}
