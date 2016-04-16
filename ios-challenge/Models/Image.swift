import Foundation
import Argo
import Curry

extension ImageContext: Decodable {}

extension Image: Decodable {
    static func decode(json: JSON) -> Decoded<Image> {
        return curry(Image.init)
            <^> json <|? "url"
            <*> json <|? "context"
            <*> json <|? "width"
            <*> json <|? "height"
    }
}

enum ImageContext: String {
    case Main = "company-main"
    case Medium = "company-thumbnail-medium"
    case Small = "company-thumbnail-small"
    case Background = "category-background"
}

struct Image {
    let url: String?
    let context: ImageContext?
    let width: Float?
    let height: Float?
}

