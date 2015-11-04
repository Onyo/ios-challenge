import Foundation
import Argo
import Curry

extension ApiResponse: Decodable {
    static func decode(j: JSON) -> Decoded<ApiResponse> {
        return curry(ApiResponse.init)
            <^> j <| "error"
    }
}

struct ApiResponse {
    let message: String
}