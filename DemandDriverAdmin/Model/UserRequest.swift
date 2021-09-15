//
//  UserRequest.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 17/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import Foundation

protocol DocumentSerializables  {
    init?(dictionary:[String:Any])
}


struct UserRequest {
//    var Booking_ID     :String
    var Start_Lat      :String
    var Start_Long     :String
   
    
    
    var dictionary:[String:Any] {
        return [
            
//            "Booking_ID"      : Booking_ID,
            "Start_Lat"       : Start_Lat,
            "Start_Long"      : Start_Long
           
        
            
            
        ]
    }
    
}

extension UserRequest : DocumentSerializables {
    init?(dictionary: [String : Any]) {
//         let Booking_ID      = dictionary["Booking_ID"] as? String,
       guard  let Start_Lat      = dictionary["Start_Lat"] as? String,
              let Start_Long     = dictionary["Start_Long"] as? String else {return nil}
        
        self.init( Start_Lat: Start_Lat, Start_Long: Start_Long)
    }
}
