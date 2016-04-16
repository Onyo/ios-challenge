//
//  Model.swift
//  Onyo
//
//  Created by Lucas Cypriano on 14/04/16.
//  Copyright © 2016 Lucas Cypriano. All rights reserved.
//


import Foundation
import ObjectMapper
import RealmSwift
import Realm


class Company: Object, Mappable {

    dynamic var numericalId : Int = 0
    dynamic var geoLat      : Double = 0.0
    dynamic var geoLon      : Double = 0.0
    dynamic var address     = ""
    dynamic var onId        = ""
    dynamic var displayName = ""
    dynamic var name        = ""
    dynamic var menuOnId    = ""
    dynamic var brand       = ""
    var image               = List<OnImage>()
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "numericalId"
    }
    
    func mapping(map: Map) {

        numericalId <- map["numericalId"]
        geoLat      <- map["geoLat"]
        geoLon      <- map["geoLon"]
        address     <- map["address"]
        onId        <- map["id"]
        displayName <- map["displayName"]
        name        <- map["name"]
        menuOnId    <- map["menu"]
        brand       <- map["brand"]
        image       <- (map["image"], ArrayTransform<OnImage>())
    }
    
}

//Issue 240 ObjectMapper: work-around found here: https://github.com/realm/realm-cocoa/issues/1120
public class StringObject: Object {
    public dynamic var value: String?
}

class Menu: Object, Mappable {
    
    dynamic var numericalId     : Int = 0
    dynamic var onId            = ""
    var categoriesOnId          = List<StringObject>()
    var categories              = List<Category>()
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "numericalId"
    }
    
    func mapping(map: Map) {
        
        numericalId     <- map["numericalId"]
        onId            <- map["id"]
        
        var options: [String]? = nil
        options <- map["categories"] // Maps to local variable
        
        options?.forEach { option in // Then fill options to `List`
            let value = StringObject()
            value.value = option
            self.categoriesOnId.append(value)
        }
    }
    
}

class Category: Object, Mappable {
    
    dynamic var numericalId : Int = 0
    dynamic var onId        = ""
    dynamic var name        = ""
    dynamic var menuOnId    = ""
    dynamic var brandOnId   = ""
    var image               = List<OnImage>()
    dynamic var order       : Int = 0
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "numericalId"
    }
    
    func mapping(map: Map) {
        
        numericalId <- map["numericalId"]
        onId        <- map["id"]
        name        <- map["name"]
        menuOnId    <- map["menu"]
        brandOnId   <- map["brand"]
        image       <- map["image"]
        order       <- map["order"]
        image       <- (map["image"], ArrayTransform<OnImage>())
    }
    
}

class OnImage: Object, Mappable {
    
    dynamic var url     = ""
    dynamic var width   : Int = 0
    dynamic var height  : Int = 0
    dynamic var context = ""
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        url     <- map["url"]
        width   <- map["width"]
        height  <- map["height"]
        context <- map["context"]
    }
    
}

//Issue 240 ObjectMapper: work-around found here: https://github.com/Hearst-DD/ObjectMapper/issues/240
class ArrayTransform<T:RealmSwift.Object where T:Mappable> : TransformType {
    typealias Object = List<T>
    typealias JSON = Array<AnyObject>
    
    func transformFromJSON(value: AnyObject?) -> List<T>? {
        let result = List<T>()
        if let tempArr = value as! Array<AnyObject>? {
            for entry in tempArr {
                let mapper = Mapper<T>()
                let model : T = mapper.map(entry)!
                result.append(model)
            }
        }
        return result
    }
    
    func transformToJSON(value: List<T>?) -> Array<AnyObject>? {
        if value?.count > 0 {
            var result = Array<AnyObject>()
            for entry in value! {
                result.append(Mapper().toJSON(entry))
            }
            return result
        }
        return nil
    }
}


//TODO: Don't repeat yourself...
class Model {
    
    func saveDataFromJSON(JSON: NSDictionary) -> [Company]{
        
        let companies: Array<Company> = Mapper<Company>().mapArray(JSON["companies"])!
        
        let categories: Array<Category> = Mapper<Category>().mapArray(JSON["categories"])!
        
        let menus: Array<Menu> = Mapper<Menu>().mapArray(JSON["menus"])!
        
        let realm = try! Realm()
        
        try! realm.write {
            
            realm.add(companies, update: true)
            realm.add(categories, update: true)
            realm.add(menus, update:true)
            
        }
        
        return companies
    }
    
    func updateMenu(menu: Menu) {
        
        let realm = try! Realm()
        
        for categoryOnId in menu.categoriesOnId {
            if let category = getCategoriesWithId(categoryOnId.value!) {
                realm.beginWrite()
                menu.categories.append(category)
                try! realm.commitWrite()
            }
        }
    }
    
    func getMenuWithId(onId: String) -> Menu? {
        
        let realm = try! Realm()
        
        if let menu = realm.objects(Menu).filter("onId == %@", onId).first{
            return menu
        }else{
            return nil
        }
    }
    
    func getCategoriesWithId(onId: String) -> Category? {
        
        let realm = try! Realm()
        
        if let category = realm.objects(Category).filter("onId == %@", onId).first{
            return category
        }else{
            return nil
        }
    }
    
    func getCompanies() -> [Company] {
        
        let realm = try! Realm()
        return Array(realm.objects(Company))
    }
    
    func getMenu() -> [Menu] {
        
        let realm = try! Realm()
        return Array(realm.objects(Menu))
    }
    
    func getCategories() -> [Category] {
        
        let realm = try! Realm()
        return Array(realm.objects(Category))
    }
    
}
