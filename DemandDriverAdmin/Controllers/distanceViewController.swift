//
//  distanceViewController.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 10/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import CoreLocation


class distanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
   
    var db:Firestore!
    
    var requestArray          = [UserRequest]()
    var bookRequestArray      = [String: Any]()
    var booking_ID            = bookingID
    var driverArray           = [DriverModel]()
    var Driver_Booking_Array  = [driverBookingModel]()
    var UserArray             = [UserModel]()

  
    var LatLong               : String = ""
    var Start_Lat             : String = ""
    var Start_Long            : String = ""
    var doc_ID                : String = ""
    var Driver_ID             : String = ""
    var Driver_Lat            : String = ""
    var Driver_Long           : String = ""
    var Car_Type              : String = ""
    var Driver_Phone_number   : String = ""
    var User_Booking_ID       : String = ""
    var Driver_Booking_ID     : String = ""
    var driver_UID            : String = ""
    var CheckBookID           : String = ""
    var driverToken           : String = ""
    var Request               : String = "Approved"
    var Driver_name : String = ""
    var timer                 : Timer!

    
    var DriverLocation        : CLLocation?
    var userLocation          : CLLocation?
    var nearestLoaction       : CLLocationDistance?
    
    
    
    @IBOutlet weak var distance: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        loadDriverDoc()
        self.distance.addSubview(self.refreshControl)

        
    }//viewdidload

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Pull to referesh
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(distanceViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
   
        loadDriverDoc()
        self.distance.reloadData()
        refreshControl.endRefreshing()
        
    }
    
    
    
    
     // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return driverArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = distance.dequeueReusableCell(withIdentifier: "distanceTableViewCell", for: indexPath) as! distanceTableViewCell
        
        let requests = driverArray[indexPath.row]
        
        print("requests::::\(requests)")
        
        cell.distancelabel?.text = driverArray[indexPath.row].Driver_ID

        cell.call.addTarget(self, action: #selector(callButtonTapped(sender:)), for: .touchUpInside)

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let approveAction = UITableViewRowAction(style: .destructive, title: "Approve") { (action, indexPath) in
            // Approve item at indexPath
            
            self.statusApprove()
            
        }
        
       approveAction.backgroundColor = UIColor.green
        
        
        return [approveAction]
    }
    
    //Table view end
    
    @objc func callButtonTapped(sender : UIButton){
       
        if let url = URL(string: "tel://\(Driver_Phone_number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
      
    }

    

    
    func loadDriverDoc(){
        
        driverArray.removeAll()
        
        self.db.collection("Driver_details").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("driverdocument::::::::::\(document.documentID) => \(document.data())")
                    
                    let Driver_ID = document.data()["Driver_ID"] as? String
                    print("Driver_ID::::\(String(describing: Driver_ID))")
                    self.Driver_ID = Driver_ID!
            //nil handled.
                   if let Driver_lat = document.data()["Driver_Lat"] as? String {
                        
                        print("Driver_lat:::::\(String(describing: Driver_lat))")
                        self.Driver_Lat = Driver_lat
                    }
                    
                    let Driver_long = document.data()["Driver_Long"] as? String
                    print("Driver_long:::::\(String(describing: Driver_long))")
                    self.Driver_Long = Driver_long!
                    let car = document.data()["Car_type"] as? String
                    print("Driver_car:::::\(String(describing: car))")
                    self.Car_Type = car!
                    let Phone_number = document.data()["Driver_Phone_number"] as? String
                    print("Driver_phone_number:::::\(String(describing: Phone_number))")
                    self.Driver_Phone_number = Phone_number!
                    
                    let driverToken = document.data()["driverToken"] as? String
                    print("Driver_phone_number:::::\(String(describing: driverToken))")
                    self.driverToken = driverToken!
                    let Driver_name = document.data()["Driver_name"] as? String
                    print("Driver_name:::::\(String(describing: Driver_name))")
                    self.Driver_name = Driver_name!
                    let item = DriverModel(Car_type: self.Car_Type, Driver_Lat: self.Driver_Lat, Driver_Long: self.Driver_Long, Driver_Phone_number: self.Driver_Phone_number, Driver_ID: self.Driver_ID, driverToken: self.driverToken, Driver_name: self.Driver_name)
//                    self.driverArray.append(item)
                    self.DistanceCal(lat: self.Driver_Lat, long: self.Driver_Long, item: item)
                    
                }
                DispatchQueue.main.async {
                    self.distance.reloadData()

                    
                }
                
                
            }
            
        }
        
        
    }//loadDriverDoc
    
    func DistanceCal(lat : String,long : String,item : DriverModel) {
        
        DriverLocation = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
        print("long::::::\(String(describing: Double(Start_Long)))")
        print("lat::::::\(String(describing: Double(Start_Lat)))")

        userLocation   = CLLocation(latitude: Double(Start_Lat)!, longitude: Double(Start_Long)!)
        print("userlocatio:::::\(String(describing: userLocation))")
        
        //this is the distance between driverLocation and startLocation (in km)
        let distance = (DriverLocation?.distance(from: userLocation!))!
        
        //Display the result in km
        print(String(format: "The distance to driver is %.01fkm", distance))
        
        
        if (distance <= 4000) {
            
            driverArray.append(item)
        }
        
    }//DistanceCal
  
    
    func statusApprove() {
        
        db.collection("Current_booking").document(User_Booking_ID).updateData([
            "Driver_ID"          : Driver_ID,
            "Driver_Phone_number": Driver_Phone_number,
            "driverToken"        : driverToken,
            "Request"            : Request,
            "Driver_name"        : Driver_name
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }//statusApprove()
    
   
    

}//class
