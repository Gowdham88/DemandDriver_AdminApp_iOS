//
//  ViewController.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 09/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import CoreLocation

public var bookingID = String()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var db:Firestore!
    var requestArray     = [requestModel]()
    var bookRequestArray = [String]()
    var DriverArray      = [String]()
    var subLoaclityArray = [String]()
    var LocationArray    = [String]()
    var driverArray      = [DriverModel]()
    var UserArray        = [UserModel]()


    var doc_ID              : String = ""
    var Start_Lat           : String = ""
    var Start_Long          : String = ""
    var Driver_Lat          : String = ""
    var Driver_Long         : String = ""
    var Car_Type            : String = ""
    var Driver_Phone_number : String = ""
    var User_Booking_ID     : String = ""
 
    
    var DriverLocation      : CLLocation?
    var userLocation        : CLLocation?
    var nearestLoaction     : CLLocationDistance?
    
    
    
    @IBOutlet weak var requestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
//        loadData()
            loadDoc()
        self.requestTableView.addSubview(self.refreshControl)

    }//viewdidload

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    //Pull to referesh
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(distanceViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        loadDoc()
        self.requestTableView.reloadData()
        refreshControl.endRefreshing()
        
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return 80.0
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return UserArray.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = requestTableView.dequeueReusableCell(withIdentifier: "requestTableViewCell", for: indexPath) as! requestTableViewCell

        let requests = UserArray[indexPath.row]
        
        print("requests::::\(requests)")
        
        cell.UsersUID?.text = UserArray[indexPath.row].User_Booking_ID

       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let vc          = storyboard.instantiateViewController(withIdentifier: "distanceViewController") as! distanceViewController
        vc.Start_Lat = UserArray[indexPath.row].Start_Lat
        vc.Start_Long = UserArray[indexPath.row].Start_Long
        vc.User_Booking_ID = UserArray[indexPath.row].User_Booking_ID
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
    }
    
  
    // Table View end

    
    func loadDoc() {
        UserArray.removeAll()
        
        getFireBaseToken { token in
    
            
                self.db.collection("Current_booking").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("document::::::::::\(document.documentID) => \(document.data())")
                            
                            print("doc::::\(self.bookRequestArray)")
                            
                            if let User_Booking_ID = document.data()["User_Booking_ID"] as? String {
                            print("User_Booking_ID::::::\(String(describing: User_Booking_ID))")
                            self.User_Booking_ID = User_Booking_ID
                            }
                            
                            if let Start_lat = document.data()["Start_Lat"] as? String {
                            print("Start_lat::::::\(String(describing: Start_lat))")
                            self.Start_Lat = Start_lat
                            }
                            
                            if let Start_long = document.data()["Start_Long"] as? String {
                            print("Start_long::::::\(String(describing: Start_long))")
                            self.Start_Long = Start_long
                            }
                            
                           let items = UserModel(User_Booking_ID: self.User_Booking_ID, Start_Lat: self.Start_Lat, Start_Long: self.Start_Long)
//                            self.DistanceCal(lat: self.Start_Lat, long: self.Start_Long, item: items)
                            self.UserArray.append(items)
                        }
                        DispatchQueue.main.async {
                            
                            self.requestTableView.reloadData()
                            
                        }
                    }
                }


        }//get firebase token
        
    }//loadDoc
    
 

    
    
   
    //Anonymously user login
    
    func getFireBaseToken(completion : @escaping (String) -> Void) {
        
        if let currentUser = Auth.auth().currentUser {
            
            currentUser.getIDToken{ idToken, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(error.localizedDescription)
                    return;
                }
                
                print(idToken ?? "empty")
                completion(idToken ?? "empty")
                
            }
            
            
        } else {
            
            Auth.auth().signInAnonymously() { (user, error) in
                
                if error != nil {
                    
                    completion("empty")
                }
                
                if let annoymususer = user {
                    
                    annoymususer.getIDToken{ idToken, error in
                        if let error = error {
                            print(error.localizedDescription)
                            completion(error.localizedDescription)
                            return;
                        }
                        
                        print(idToken ?? "empty")
                        completion(idToken ?? "empty")
                        
                    }
                    
                    
                    
                    
                } else {
                    
                    completion("empty")
                }
                
                
            }
            
        }
        
    }//Anonymously user login
    
    
}//class

