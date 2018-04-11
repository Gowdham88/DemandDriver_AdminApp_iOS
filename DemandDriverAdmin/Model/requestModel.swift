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
    var UsersUID:String
    var UID    :String
   
    
    
    var dictionary:[String:Any] {
        return [
            "UsersUID":UsersUID,
            "UID"     : UID
          
            
        ]
    }
    
}

extension requestModel : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let UsersUID = dictionary["UsersUID"] as? String,
            let UID     = dictionary["UID"] as? String else {return nil}
        
        self.init(UsersUID: UsersUID, UID: UID)
    }
}


