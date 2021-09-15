//
//  UserModel.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 18/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import Foundation

struct UserModel {
    
    var User_Booking_ID    : String
    var Start_Lat          : String
    var Start_Long         : String
    
    
    init(User_Booking_ID : String,  Start_Lat     :String,Start_Long    : String) {
        
        self.User_Booking_ID   = User_Booking_ID
        self.Start_Lat          = Start_Lat
        self.Start_Long         = Start_Long

    }
    
}
