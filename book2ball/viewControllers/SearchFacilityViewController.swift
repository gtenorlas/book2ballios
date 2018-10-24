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
    
    var facilities = ["Jays" : ["first facility","good facility",10 ], "Leafs" : ["second facility","ok facility",20], "Raptors"  : ["third facility","best facility",30], "Marlies"  : ["forth facility","fine facility",40], "FC" : ["5th facility","nice facility",50]]
    
   // @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet var myTableView : UITableView!
    
    var numKm: Int = 1
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilities.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        for (kind, kilo) in facilities{
       // tableCell.textLabel?.text = (facilities)[indexPath.row] as! String
        }
        return tableCell
    }
    
    @IBAction func indexChanged(sender : UISegmentedControl) {
        // This all works fine and it prints out the value of 3 on any click
        print("# of Segments = \(sender.numberOfSegments)")
        
        numKm = sender.selectedSegmentIndex + 1 //index start at 0, but index1 is 1hour, so add 1
        
    } // indexChanged for the Segmented Control
    
    @IBAction func onSubmit(_ sender: UIButton) {
        
        for (kind, kilo) in facilities{
            for number in kilo {
              //  if number == numKm {
               // largest = number
              //  }
              } }
      
        
        
       // performSegue(withIdentifier: "paypalSegue", sender: nil)
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
