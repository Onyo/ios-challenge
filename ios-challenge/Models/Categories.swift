import Foundation
import Argo
import Curry

extension Categories: Decodable {
    static func decode(json: JSON) -> Decoded<Categories> {
        let category = curry(Categories.init)
        return category
            <^> json <| "numericalId"
            <*> json <|? "id"
            <*> json <|? "name"
            <*> json <|? "parent"
            <*> json <|? "menu"
            <*> json <|? "brand"
            <*> json <|? "order"
            <*> json <||? "image"
    }
}

struct Categories {
    let numericalId: Int
    let id: String?
    let name: String?
    let parent: String?
    let menu: String?
    let brand: String?
    let order: Int?
    let images: [Image]?
}