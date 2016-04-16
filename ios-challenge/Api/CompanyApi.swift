import Foundation
import Moya
import Argo
import RxSwift

class CompanyApi {
    
    static var provider = RxMoyaProvider<OnyoApi>(endpointClosure: endpointsClosure())
    
    class func companies() -> Observable<CompanySummary> {
        return provider.request(.Companies())
            .successfulStatusCodes()
            .mapToDomain()
    }
}