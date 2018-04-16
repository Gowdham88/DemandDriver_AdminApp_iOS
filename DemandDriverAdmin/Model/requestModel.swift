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

struct requestUserModel {
    
        var UsersUID:String
        var UID    :String
    
        var dictionary:[String:Any] {
            return [
                        "UsersUID": UsersUID,
                        "UID"     : UID
                    ]
                }
        }


struct requestDriverModel {
    
    var driverName:String
    var driverphoneNumber:String
    var DriverLat:String
    var DriverLong:String
    var UserLat:String
    var UserLong:String
    
    var dictionary:[String:Any] {
        return [
            "Driver_name":driverName,
            "Driver_Phone_number": driverphoneNumber,
            "Driver_Lat": DriverLat,
            "Driver_Long": DriverLong,
            "Start_Lat": UserLat,
            "Start_Long": UserLong
        ]
    }
}

extension requestDriverModel : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let driverName = dictionary["Driver_name"] as? String,
            let driverphoneNumber = dictionary["Driver_Phone_number"] as? String,
            let DriverLat = dictionary["Driver_Lat"] as? String,
        let DriverLong = dictionary["Driver_Long"] as? String,
        let UserLat = dictionary["Start_Lat"] as? String,
        let UserLong = dictionary["Start_Long"] as? String else {return nil}
        
        self.init(driverName: driverName, driverphoneNumber: driverphoneNumber, DriverLat: DriverLat, DriverLong: DriverLong, UserLat: UserLat, UserLong: UserLong)
    }
}

extension requestUserModel : DocumentSerializable {
    init?(dictionary: [String : Any]) {
                guard let UsersUID = dictionary["UsersUID"] as? String,
                   let UID     = dictionary["UID"] as? String else {return nil}
              
                    self.init(UsersUID: UsersUID, UID: UID)

    }
}


