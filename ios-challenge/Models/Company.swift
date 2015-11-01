import Foundation
import Argo
import Curry

extension Company: Decodable {
    static func decode(json: JSON) -> Decoded<Company> {
        let company = curry(Company.init)
        return company
            <^> json <|? "id"
            <*> json <|? "numericalId"
            <*> json <|? "geoLat"
            <*> json <|? "geoLon"
            <*> json <|? "name"
            <*> json <|? "displayName"
            <*> json <|? "address"
            <*> json <||? "image"
    }
}

struct Company {
    let id: String?
    let numericalId: Int?
    let geoLat: Double?
    let geoLon: Double?
    let name: String?
    let displayName: String?
    let address: String?
    let images: [Image]?
    
}