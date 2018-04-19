//
//  DriverModel.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 18/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import Foundation


struct DriverModel {
    //    var Booking_ID     :String
    var Car_type            : String
    var Driver_Lat          : String
    var Driver_Long         : String
    var Driver_Phone_number : String
    var Driver_ID           : String
    var driverToken         : String
    
    init(Car_type       : String,Driver_Lat     :String,Driver_Long    : String, Driver_Phone_number: String, Driver_ID: String, driverToken: String) {
        
        self.Car_type            = Car_type
        self.Driver_Lat          = Driver_Lat
        self.Driver_Long         = Driver_Long
        self.Driver_Phone_number = Driver_Phone_number
        self.Driver_ID           = Driver_ID
        self.driverToken         = driverToken
    }
   
}
