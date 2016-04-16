import Foundation
import Moya
import RxSwift

enum OnyoApi {
    case Companies()
}

extension OnyoApi : MoyaTarget {
    var baseURL: NSURL {
        return NSURL(string: "http://api.staging.onyo.com/v1/mobile")!
    }
    
    var path: String {
        switch self {
        case .Companies():
            return "/brand/1/company"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .GET
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        default: return nil
        }
    }
    
    var sampleData: NSData {
        switch self {
        default: return NSData()
        }
    }
}

func url(route: MoyaTarget) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}