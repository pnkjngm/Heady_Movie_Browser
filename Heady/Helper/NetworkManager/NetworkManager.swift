//
//  NetworkManager.swift
//  Heady
//
//  Created by iSteer Inc. on 14/11/17.
//  Copyright © 2017 iSteer Inc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    class func getHTTPs(url : String, success:@escaping (JSON) -> (), failure:@escaping (String) -> ()) {
        Alamofire.request(url, method: .get).responseJSON { response in
            
        if response.result.isSuccess {
            let resJson = JSON(response.result.value!)
            if !resJson.isEmpty {
                success(resJson)
            } else {
                failure("Unable to find Server")
            }
        }
        if response.result.isFailure {
            failure("Unable to find Server")
        }
    }
    
    }
}
