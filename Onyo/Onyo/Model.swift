//
//  Model.swift
//  Onyo
//
//  Created by Lucas Cypriano on 14/04/16.
//  Copyright © 2016 Lucas Cypriano. All rights reserved.
//

import Foundation
import ObjectMapper

class Company: Mappable {
    
    var numericalId :Int?
    var geoLat      :Double?
    var geoLon      :Double?
    var address     :String?
    var onId        :String?
    var displayName :String?
    var name        :String?
    var menu        :[Menu]?
    var brand       :String?
    var image       :[OnImage]?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        numericalId <- map["numericalId"]
        geoLat      <- map["geoLat"]
        geoLon      <- map["geoLon"]
        address     <- map["address"]
        onId        <- map["id"]
        displayName <- map["displayName"]
        name        <- map["name"]
        menu        <- map["menu"]
        brand       <- map["brand"]
        image       <- map["image"]
    }
    
}

class Menu: Mappable {
    
    var numericalId :Int?
    var onId        :String?
    var categories  :[Category]?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        numericalId <- map["numericalId"]
        onId        <- map["id"]
        categories  <- map["categories"]
    }
    
}

class Category: Mappable {
    
    var numericalId :Int?
    var onId        :String?
    var name        :String?
    var menu        :String?
    var brand       :String?
    var image       :String?
    var order       :Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        numericalId <- map["numericalId"]
        onId        <- map["id"]
        name        <- map["name"]
        menu        <- map["menu"]
        brand       <- map["brand"]
        image       <- map["image"]
        order       <- map["order"]
    }
    
}

class OnImage: Mappable {
    
    var url     :String?
    var width   :Int?
    var height  :Int?
    var context :String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        url     <- map["url"]
        width   <- map["width"]
        height  <- map["height"]
        context <- map["context"]
    }
    
}