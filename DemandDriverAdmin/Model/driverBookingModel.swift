//
//  driverBookingModel.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 19/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import Foundation

struct driverBookingModel {
    
    var Driver_Booking_ID : String
    var driver_UID : String
  
    
    init(Driver_Booking_ID: String, driver_UID: String) {
        
       self.Driver_Booking_ID = Driver_Booking_ID
        self.driver_UID = driver_UID
      
    }
    
}
