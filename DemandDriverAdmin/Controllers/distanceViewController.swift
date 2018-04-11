//
//  distanceViewController.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 10/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import UIKit

class distanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var distanceArray = ["5 km", "10 km", "15 km", "More Than 15 Km"]

    @IBOutlet weak var distance: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    

}//class
