//
//  Connection.swift
//  Onyo
//
//  Created by Lucas Cypriano on 16/04/16.
//  Copyright © 2016 Lucas Cypriano. All rights reserved.
//

import Foundation
import Alamofire

typealias Success = (objectList: [AnyObject]) -> Void
typealias Fail = (error: NSError) -> Void

private let api = "http://api.staging.onyo.com/v1/mobile/brand/1/company"

class Connection {
    
    func loadData(onSuccess: Success, onFail: Fail) {
        
        let URL = api
        Alamofire.request(.GET, URL).responseJSON { response in
            
            let model = Model()
            
            guard response.result.error == nil else {
                
                dispatch_async(dispatch_get_main_queue()) {
                    onFail(error: response.result.error!)
                }
                
                return
            }
        
            if let JSON = response.result.value {
                
                let company = model.saveDataFromJSON(JSON as! NSDictionary)
                
                dispatch_async(dispatch_get_main_queue()) {
                    onSuccess(objectList: company)
                }
            }
        }
    }
}
