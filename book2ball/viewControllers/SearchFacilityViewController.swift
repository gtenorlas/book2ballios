//
//  SearchFacilityViewController.swift
//  book2ball
//
//  Created by Xcode User on 2018-10-22.
//  Copyright © 2018 moghid saad. All rights reserved.
//

import UIKit
/*
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

}*/
class SearchFacilityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var nameData:[String]=[]
    var cityData:[String]=[]
    var provinceData:[String]=[]
    var distanceData:[Double]=[]
    var facilityList:Array<FacilityData> = []
    @IBOutlet weak var menuButton : UIBarButtonItem!
    
    //var facilities = ["Fac1","Fac2", "Fac3" , "Fac4" , "Fac5"]
    //var cities : [String : String] = ["Fac1" : "Brampton","Fac2" : "Brampton", "Fac3" : "Mississauga", "Fac4" : "Toronto", "Fac5" : "Vancouver"]
    //var provinces : [String : String ] = ["Fac1" : "Ontario","Fac2" : "Ontario", "Fac3" : "Ontario", "Fac4" : "Ontario", "Fac5" : "British Colombia"]
    //var distances : [String : Double] = ["Fac1" : 8.2, "Fac2" : 9.3, "Fac3" : 11.0, "Fac4" : 50, "Fac5" : 5000]
    
    
    func fetch(){
        
        let semaphore = DispatchSemaphore (value : 0)
        
        // create post request
        let url = NSURL(string: "http://mags.website/api/facility/")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        
        // insert json data to the request
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
                return
            }
            
            //print (String.init(data: data!, encoding: .ascii) ?? "no data")
            //let json = String.init(data: data!, encoding: .ascii) ?? "no data"
            let json =  (try? JSONSerialization.jsonObject(with: data!, options: [])) as? NSArray
            //let json =  try? JSONSerialization.jsonObject(with: data!, options: [])
            //let objectCount = json?.count
            //, let facilities = json[""] as? [Any]
            //, let facNames = json["facilityName"] as? [String:Any]
            //, let properties = firstFeature["properties"] as? [String:Any]
            //, let taxiCount = properties["taxi_count"] as? Int
            
            for eachObject in json! {
                let facility = FacilityData()
                let jsonDict = eachObject as? NSDictionary
                facility.facilityId = jsonDict!["facilityId"] as! Int
                facility.facilityName = jsonDict!["facilityName"] as! NSString
                facility.facilityDescription = jsonDict!["facilityDescription"] as! NSString
                facility.addLine1 = jsonDict!["line_1"] as! NSString
                facility.addLine2 = jsonDict!["line_2"] as! NSString
                facility.addLine3 = jsonDict!["line_3"] as! NSString
                facility.city = jsonDict!["city"] as! NSString
                facility.province = jsonDict!["province"] as! NSString
                facility.postalCode = jsonDict!["postalCode"] as! NSString
                facility.country = jsonDict!["country"] as! NSString
                
                let courts = Court.fetch(data: jsonDict!["courts"])
                facility.courtsList = courts
                
                facility.contactNumber = jsonDict!["contactNumber"] as! NSString
                facility.distance = 100.00
                
                self.facilityList.append(facility)
                
                
                print("----------------------")
                print(facility.facilityId)
                print(facility.facilityName)
                print(facility.facilityDescription)
                print(facility.addLine1)
                print(facility.addLine2)
                print(facility.addLine3)
                print(facility.city)
                print(facility.province)
                print(facility.postalCode)
                print(facility.country)
                print(facility.contactNumber)
                print(facility.distance)
                print("----------------------")
                print("court count: \(facility.courtsList.count)")
            }
            
            
            semaphore.signal()
            }.resume()
        _=semaphore.wait(timeout: .distantFuture)
        
        mainDelegate.facList = self.facilityList
    }
    
    
    
    
    
    // @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet var myTableView : UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.facilityList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell : SiteCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        
        let facilityName = nameData[indexPath.row]
        let city = cityData[indexPath.row]
        let province = provinceData[indexPath.row]
        let distance = distanceData[indexPath.row]
        
        
        tableCell.facilityName.text = facilityName
        tableCell.city.text = city
        tableCell.province.text = province
        tableCell.distance.text = String(format:"%.2f", distance)+" km away"
        
        
        return tableCell
    }
    // step 9 making cells editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainDelegate.selectedFacilityData = facilityList[indexPath.row]
        performSegue(withIdentifier: "segueToCourtsViewController", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetch()
        
        for each:FacilityData in facilityList{
            //add to array
            nameData.append(each.facilityName as String)
            cityData.append(each.city as String)
            provinceData.append(each.province as String)
            distanceData.append(each.distance)
            
        }
        
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
    
    @IBAction func unwindToSeachFacilityViewController(sender : UIStoryboardSegue)
    {
        
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
