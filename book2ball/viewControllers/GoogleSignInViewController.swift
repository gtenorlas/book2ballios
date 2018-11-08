//
//  GoogleSignInViewController.swift
//  Book2Ball
//
//  Created by Moghid Saad User on 2018-04-14.
//  Copyright © 2018 Xcode User. All rights reserved.
//

import UIKit
import GoogleSignIn

class GoogleSignInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var menuButton : UIBarButtonItem!
    
    //implement sign in as part of GIDSignInDelegate requirement
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        //print error
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Grab the user informatioon
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            //let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            var user: Customer = GoogleRegistration(googleUserId: userId! as String, googleUserToken: idToken! as String)
            user.email = email! as NSString
            user.firstName = givenName! as NSString
            user.lastName = familyName! as NSString
            user.originate = "google"
            
            let response = Customer.fetchAccount(customer: user)
            if let invalid = response as? String {
                print ("response is \(invalid)")
                user.username = email! as NSString
                user.password = "null"
                user.contactNumber = "null"
                user.startDate = "10-22-2018-13-30"
                user.endDate = "null"
                user.status = "Active"
                Customer.save(customer: user)
                mainDelegate.userLoggedIn = user
                performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
            }else {
                user = response as! Customer
                mainDelegate.userLoggedIn = user
                performSegue(withIdentifier: "searchFacilitySegue", sender: nil)
            }
            
            mainDelegate.userLoggedIn = user //user signed in
            
           // performSegue(withIdentifier: "segueToSearchFacility", sender: nil)
        }
    }
    
    //signing out
    @IBAction func SignOutTap(_ sender: UIButton) {
        //log out to google
        GIDSignIn.sharedInstance().signOut()
        
        mainDelegate.userLoggedIn = Customer() //user logged out
        
        //go back to home controller
        performSegue(withIdentifier: "unwindToHomeSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //requirement for Google to delegate to self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        //add a google button in the center of the view
        let googleSignInButton = GIDSignInButton(frame: CGRect(x: 0,y: 0,width: 100,height: 50))
        googleSignInButton.center=view.center
        view.addSubview(googleSignInButton)
        sideMenu()
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
    
}
