//
//  requestModel.swift
//  DemandDriverAdmin
//
//  Created by CZSM2 on 09/04/18.
//  Copyright © 2018 CZSM2. All rights reserved.
//

import Foundation

protocol DocumentSerializable  {
    init?(dictionary:[String:Any])
}


struct requestModel {
    var Booking_ID:String
    var UID    :String
   
    
    
    var dictionary:[String:Any] {
        return [
            "Booking_ID":Booking_ID,
            "UID"     : UID
          
            
        ]
    }
    
}

extension requestModel : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let Booking_ID = dictionary["Booking_ID"] as? String,
            let UID     = dictionary["UID"] as? String else {return nil}
        
        self.init(Booking_ID: Booking_ID, UID: UID)
    }
}


