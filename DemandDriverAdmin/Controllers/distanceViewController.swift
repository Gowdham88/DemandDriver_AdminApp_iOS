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
    
    var distanceArray = ["5 km", "10 km", "15 km", "More Than 15 Km"]
    var db:Firestore!
    var requestArray = [UserRequest]()
    var bookRequestArray = [String: Any]()
    var LatLong: String = ""
    var Start_Lat:String = ""
    var Start_Long:String = ""
    var booking_ID = bookingID
    @IBOutlet weak var distance: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        loadData()
        // Do any additional setup after loading the view.
        
    }//viewdidload

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distanceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = distance.dequeueReusableCell(withIdentifier: "distanceTableViewCell", for: indexPath) as! distanceTableViewCell
        
       cell.distancelabel?.text = distanceArray[indexPath.row]
        
        return cell

    }
    
    //Table view end
    
    
    func loadData() {
//        getFireBaseToken { token in
        
            self.db.collection("Current_booking").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        var id = document.documentID
                        print("id:::::\(id)")
//                        self.requestArray.append(UserRequest(St: document["Booking_ID"] as! String, Booking_ID: id))
//                        self.requestArray.append(UserRequest(Start_Lat: document["Start_Lat"] as! String, Start_Long: document["Start_Long"] as! String))
//                        let requests = self.requestArray.append(UserRequest(Start_Lat: document["Start_Lat"] as! String, Start_Long: document["Start_Long"] as! String))
                    
                     
                        
                        self.LatLong = "\(UserRequest.init(Start_Lat:  document["Start_Lat"] as! String, Start_Long: document["Start_Long"] as! String), id = self.booking_ID)"
                        print("LatLong::::\(self.LatLong)")
                        print("position is::",self.requestArray)
                        
                        DispatchQueue.main.async {
                            
                        }
                    }
                }
            }
            
//        }//get firebase token
        
    }//loadData
    
    
    
    

}//class
