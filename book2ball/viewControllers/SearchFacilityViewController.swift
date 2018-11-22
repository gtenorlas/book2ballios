//
//  SearchFacilityViewController.swift
//  MAGS
//
//  Created by Xcode User on 2018-10-22.
//  Copyright © 2018 moghid saad. All rights reserved.
//
/*
 This class will prompt the user to allow the application to acces it's current location. The latitude and longitude are retrieved upon accepting the request. This class will also calculate the distance of the user current location from the array of Facilities retrieved from the remote database.
 */

import UIKit
import Foundation
import CoreLocation

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

class SearchFacilityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet var myTableView : UITableView!
    @IBOutlet weak var menuButton : UIBarButtonItem!
    @IBOutlet var searchBar : UISearchBar!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var facilityList:Array<FacilityData> = []
    var viewingFacilities:Array<FacilityData> = []
    var currentViewingFacs:Array<FacilityData> = []
    var initialLocation:CLLocation = CLLocation()
    var locationManager = CLLocationManager()
    var SegmentIndexSelected:Int = 4
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        self.initialLocation = CLLocation(latitude: locations[0].coordinate.latitude,longitude: locations[0].coordinate.longitude)
    }
    
    func locationManager(_ manager:CLLocationManager, didFailWithError error: Error)
    {
        print("unable to access your current location")
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        guard !searchText.isEmpty else { self.currentViewingFacs = viewingFacilities
            self.myTableView.reloadData()
            return
        }
        self.currentViewingFacs = viewingFacilities.filter({fac -> Bool in
            //guard let text = searchBar.text else {return false}
            return fac.facilityName.contains(searchText)
        })
        self.myTableView.reloadData()
    }
    
    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
    {
        
    }
    
    
    @IBAction func viewWithinDistance(_ sender: Any) {
        let indexSelected = segment.selectedSegmentIndex
        self.viewingFacilities = []
        if(!self.facilityList.isEmpty)
        {
        switch (indexSelected) {
        case 0:
            for each:FacilityData in self.facilityList{
                if(each.distance <= 10.00)
                {
                    viewingFacilities.append(each)
                }
            }
            self.currentViewingFacs = viewingFacilities
            self.myTableView.reloadData()
            self.SegmentIndexSelected = 0
            
        case 1:
            for each:FacilityData in self.facilityList{
                if(each.distance <= 20.00)
                {
                    viewingFacilities.append(each)
                }
            }
            self.currentViewingFacs = viewingFacilities
            self.myTableView.reloadData()
            self.SegmentIndexSelected = 1
        case 2:
            for each:FacilityData in self.facilityList{
                if(each.distance <= 30.00)
                {
                    viewingFacilities.append(each)
                }
            }
            self.currentViewingFacs = viewingFacilities
            self.myTableView.reloadData()
            self.SegmentIndexSelected = 2
        case 3:
            for each:FacilityData in self.facilityList{
                if(each.distance <= 40.00)
                {
                    viewingFacilities.append(each)
                }
            }
            self.currentViewingFacs = viewingFacilities
            self.myTableView.reloadData()
            self.SegmentIndexSelected = 3
        case 4:
            viewingFacilities = self.facilityList
            self.currentViewingFacs = viewingFacilities
            self.myTableView.reloadData()
            self.SegmentIndexSelected = 4
        default:
            print("No select")
        }
        }
    }
    
    
    func findDistance(address:String,facility: FacilityData)->FacilityData
    {
        let locEnteredText = address
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(locEnteredText, completionHandler:
            {(placemarks, error) in
                if(error != nil)
                {
                    print("error")
                    
                }
                else{
                    if let placemark = placemarks?.first{
                        let coordinates : CLLocationCoordinate2D =
                            placemark.location!.coordinate
                        let newLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                        
                        print("$$$$$$$$$$$$$$$$$$$$$$$$$$")
                        print(self.initialLocation.coordinate.latitude)
                        print(self.initialLocation.coordinate.longitude)
                        print(newLocation.coordinate.latitude)
                        print(newLocation.coordinate.longitude)
                        let dist = (self.initialLocation.distance(from: newLocation))/1000
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                            facility.distance = dist
                        })
                        return
                    }
                }
        })
        return facility
    }
    
    func findDistFromLatLong()
    {
        if(!facilityList.isEmpty)
        {
        for each:FacilityData in self.facilityList{
            let facLocation = CLLocation(latitude: each.lat, longitude: each.long)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let dist = (self.initialLocation.distance(from: facLocation))/1000
                each.distance = dist
            }
        }
        }
    }
    
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
            
            let json =  (try? JSONSerialization.jsonObject(with: data!, options: [])) as? NSArray
            if (json != nil){
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
                facility.distance = 0.00
                facility.lat = Double(jsonDict!["lat"] as! String)!
                facility.long = Double(jsonDict!["lng"] as! String)!
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
            }
            
            semaphore.signal()
            }.resume()
        _=semaphore.wait(timeout: .distantFuture)
        
        mainDelegate.facList = self.facilityList
    }
    
    func getDistanceForFacilities()
    {
        var address:String
        for each:FacilityData in self.facilityList{
            address = "\(each.addLine1), \(each.city), \(each.province), \(each.postalCode)"
            print("&&&&&&&&&&&&")
            print(address)
            var fac:FacilityData
            fac = self.findDistance(address: address, facility: each)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                each.distance = fac.distance
            }
        }
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.currentViewingFacs.count
    }
    
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FacilityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FacilityTableViewCell") as? FacilityTableViewCell ?? FacilityTableViewCell(style: .default, reuseIdentifier: "FacilityTableViewCell")
        
       cell.contentView.backgroundColor = UIColor (white: 0.90, alpha: 1)
        
        let distance = self.currentViewingFacs[indexPath.row].distance
        
        //cell.selectionStyle = .none
        
        let currentFacility = self.currentViewingFacs[indexPath.row]
        
        var address = ("\(currentFacility.addLine1) \n")
        if currentFacility.addLine2 != "" {
            address += ("\(currentFacility.addLine2) \n")
        }
        if currentFacility.addLine3 != "" {
            address += ("\(currentFacility.addLine3) \n")
        }
        address += ("\(currentFacility.city), ")
        address += ("\(currentFacility.province)   ")
        if currentFacility.postalCode != "" {
            address += ("\(currentFacility.postalCode) \n")
        }
        address += ("\(currentFacility.country) \n")
        address += ("\(currentFacility.contactNumber)")
        
        
        
        cell.select.backgroundColor = UIColor(red: 8.0/255, green: 104.0/255, blue: 244.0/255, alpha: 1.0)
        cell.cellView.backgroundColor = UIColor(rgb: 0xFFFFFF)
        cell.facilityName.text = self.currentViewingFacs[indexPath.row].facilityName as String
        cell.facilityAddress.text = address as String
        cell.facilityDistance.text  = String(format:"%.2f", distance)+" km away"
        return cell
        
        
        /*
        let tableCell : SiteCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        let facilityName = self.currentViewingFacs[indexPath.row].facilityName
        let city = self.currentViewingFacs[indexPath.row].city
        let province = self.currentViewingFacs[indexPath.row].province
        let distance = self.currentViewingFacs[indexPath.row].distance
        
        tableCell.facilityName.text = facilityName as String
        tableCell.city.text = city as String
        tableCell.province.text = province as String
        tableCell.distance.text = String(format:"%.2f", distance)+" km away"
        
        
        return tableCell
        */
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        mainDelegate.selectedFacilityData = self.currentViewingFacs[indexPath.row]
        performSegue(withIdentifier: "segueToCourtsViewController", sender: nil)
    }
    
    func sorterForFacilityDistanceASC(this:FacilityData, that:FacilityData) -> Bool {
        return this.distance < that.distance
    }
    
    func alterLayout()
    {
        myTableView.tableHeaderView = UIView()
        myTableView.estimatedSectionHeaderHeight = 60
        navigationItem.titleView = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       myTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted ||
                CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
        } else{
            print("Please turn on location services or GPS")
        }
        
        self.fetch()
        self.findDistFromLatLong()
        
        print("!!!!!!!!!!!!!!!!!!!!")
        print(self.facilityList.count)
        print("!!!!!!!!!!!!!!!!!!!!")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("reloading")
            self.facilityList.sort(by: self.sorterForFacilityDistanceASC)
            self.viewingFacilities = self.facilityList
            self.currentViewingFacs = self.viewingFacilities
            self.myTableView.reloadData()
        })
        alterLayout()
        
        sideMenu()
        navigationController?.navigationBar.tintColor = UIColor(red: 1.0/255, green: 90.0/255, blue: 201.0/255, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red: 1.0/255, green: 90.0/255, blue: 201.0/255, alpha: 1.0)
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
    
    @IBAction func unwindToSeachFacilityViewController(sender : UIStoryboardSegue)
    {
        facilityList = []
        viewingFacilities = []
        currentViewingFacs = []
        self.myTableView.reloadData()
        viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.segment.selectedSegmentIndex = self.SegmentIndexSelected
            self.viewWithinDistance(self.segment)
        })
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
