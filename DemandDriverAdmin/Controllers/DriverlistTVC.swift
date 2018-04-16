//
//  DriverlistTVC.swift
//  DemandDriverAdmin
//
//  Created by Gowdhaman on 13/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class DriverlistTVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var db:Firestore!
    var requestArray = [requestDriverModel]()
    
    @IBOutlet var driversListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        
        loadDriverData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requestArray.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DriverlistTableViewCell
        
        let requests = requestArray[indexPath.row]
        cell.driverName.text = requests.driverName
        cell.driverphoneNumber.text = requests.driverphoneNumber
        cell.driverDistance.text = "Distance"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let number = URL(string: "tel://" + requestArray[indexPath.row].driverphoneNumber) else { return }
        
        UIApplication.shared.open(number)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
    
        let Assign = UITableViewRowAction(style: .normal, title: "Assign") { action, index in
            print("Assign button tapped")
            
        }
        Assign.backgroundColor = .green
        
        let Cancel = UITableViewRowAction(style: .normal, title: "Cancel") { action, index in
            
            print("Cancel button tapped")

        }
        Cancel.backgroundColor = .blue
        
        return [Assign, Cancel]
    }
    
    func loadDriverData() {
        getFireBaseToken { token in
            
            self.db.collection("Current_booking").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let id = document.documentID
                        print("id:::::\(id)")
                        
                        self.requestArray.append(requestDriverModel(driverName: document["Driver_name"] as! String, driverphoneNumber: document["Driver_Phone_number"] as! String, DriverLat: document["Driver_Lat"] as! String, DriverLong: document["Driver_Long"] as! String, UserLat: document["Start_Lat"] as! String, UserLong: document["Start_Long"] as! String))

                        print("position is::",self.requestArray)
                        
                        DispatchQueue.main.async {
                            self.driversListTableView.reloadData()
                            
                        }
                    }
                }
            }
            
        }//get firebase token
        
    }
    
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
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
