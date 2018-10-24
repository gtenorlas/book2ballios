//
//  SearchFacilityViewController.swift
//  book2ball
//
//  Created by Xcode User on 2018-10-22.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit

class SearchFacilityViewController: UIViewController {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var facilities : [String : Any] = ["Jays" : ["first facility","good facility","10 km"], "Leafs" : ["second facility","ok facility","20 km"], "Raptors"  : ["third facility","best facility","30 km"], "Marlies"  : ["forth facility","fine facility","40 km"], "FC" : ["5th facility","nice facility","50 km"]]
    
   // @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segment: UISegmentedControl!
    var numKm: Int = 1
    
    @IBAction func indexChanged(sender : UISegmentedControl) {
        // This all works fine and it prints out the value of 3 on any click
        print("# of Segments = \(sender.numberOfSegments)")
        
        numKm = sender.selectedSegmentIndex + 1 //index start at 0, but index1 is 1hour, so add 1
        
    } // indexChanged for the Segmented Control
    
    @IBAction func onSubmit(_ sender: UIButton) {
        
      
        
        
        performSegue(withIdentifier: "paypalSegue", sender: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        // Do any additional setup after loading the view.
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
