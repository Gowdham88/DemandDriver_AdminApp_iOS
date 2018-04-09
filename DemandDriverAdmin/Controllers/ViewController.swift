//
//  ViewController.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 09/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
    var requestModels: requestModels?
    var phoneNumber: String?
    var cartype: String?
    var address: String?
    var hallId: String?


    @IBOutlet weak var requestTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        requestModels.getSession(forHallId: hallId) { (session) in
            //Check to see if you got a valid session, and assign to your session variable
            if let session = session {
                self.requestModels = session
            }
            DispatchQueue.main.async {
                self.requestModels.reloadData()
            }
        }


    }//viewdidload

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestTableViewCell", for: indexPath) as! requestTableViewCell
        
        cell.phoneNumber.text = requestModels?.phoneNumber
        cell.cartype.text = requestModels?.cartype
        cell.address.text = requestModels?.address
        
        return cell
    }
     func getSession(forHallId hallId: String, _ completion: (_ session: requestModels?)->()) {
        Firestore.firestore().collection("UsersBookingRequest").whereField("id", isEqualTo: hallId).getDocuments() {
            querySnapshot, error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                for document in (querySnapshot?.documents)! {
                    if let phoneNumber = document.data()["phoneNumber"] as? String {
                        self.phoneNumber = phoneNumber
                    }
                    if let cartype = document.data()["cartype"] as? String {
                        self.cartype = cartype
                    }
                    if let address = document.data()["address"] as? String {
                        self.address = address
                    }
                }
                DispatchQueue.main.async {
                    self.requestTableView.reloadData()
                }
            }
        }
    }
}//class

