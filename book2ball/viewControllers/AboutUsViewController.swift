//
//  AboutUsViewController.swift
//  book2ball
//
//  Created by Xcode User on 2018-11-01.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var menuButton : UIBarButtonItem!
    var sidebarView: RearTableViewController!
    var blackScreen: UIView!
    
    @IBOutlet weak var imgGene: UIImageView!
    @IBOutlet weak var imgMo: UIImageView!
    @IBOutlet weak var imgShanu: UIImageView!
    @IBOutlet weak var imgAnthony: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgMo.roundedImage()
        imgGene.roundedImage()
        imgShanu.roundedImage()
        imgAnthony.roundedImage()
        
        sideMenu()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = UIColor(red: 54.0/255, green: 116.0/255, blue: 216.0/255, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red: 54.0/255, green: 116.0/255, blue: 216.0/255, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor : UIColor.white]
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
