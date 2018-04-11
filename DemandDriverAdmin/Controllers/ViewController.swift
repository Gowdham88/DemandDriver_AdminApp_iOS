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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var db:Firestore!
    var requestArray = [requestModel]()
    var bookRequestArray = [String: Any]()


    @IBOutlet weak var requestTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        loadData()

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
        
        return requestArray.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = requestTableView.dequeueReusableCell(withIdentifier: "requestTableViewCell", for: indexPath) as! requestTableViewCell

        let requests = requestArray[indexPath.row]
        
        print("requests::::\(requests)")
        
        cell.UsersUID?.text = "\(requests.UsersUID)"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let vc          = storyboard.instantiateViewController(withIdentifier: "distanceViewController") as! distanceViewController
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
    }
    
  
    // Table View end
    
    func loadData() {
        getFireBaseToken { token in
         
            self.db.collection("UsersCurrentBooking").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let id = document.documentID
                        print("id:::::\(id)")
                        self.requestArray.append(requestModel(UsersUID: document["UsersUID"] as! String, UID: id))
                        print("position is::",self.requestArray)
                        
                        DispatchQueue.main.async {
                            self.requestTableView.reloadData()
                            
                        }
                    }
                }
            }
         
      }//get firebase token
        
    }//loadData
    
    
    
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

