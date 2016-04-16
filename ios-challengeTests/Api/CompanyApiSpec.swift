import Quick
import Nimble
import Argo
import RxSwift
@testable import ios_challenge

class CompanyApiSpec: QuickSpec {
    
    lazy var disposeBag = DisposeBag()
    
    override func spec() {
        fdescribe("CompanyApi") {
            fcontext("get companies") {
                var companySummary: CompanySummary?
                beforeEach {
                    CompanyApi.companies()
                        .subscribe({ (event) -> Void in
                            switch event {
                            case .Next(let company):
                                companySummary = company
                            case .Error(let error):
                                debugPrint(error)
                            default: break
                            }
                        })
                        .addDisposableTo(self.disposeBag)
                }
                
                fit("companySummary should not be nil") {
                    expect(companySummary).toEventuallyNot(beNil(), timeout: 10)
                }

                fit("name should be eq Gula Gula") {
                    expect(companySummary?.name).toEventually(equal("Gula Gula"), timeout: 10)
                }
                
                fit("companies should not be empty") {
                    expect(companySummary?.companies).toEventuallyNot(beEmpty(), timeout: 10)
                }
                
                fit("categories should not be empty") {
                    expect(companySummary?.categories).toEventuallyNot(beEmpty(), timeout: 10)
                }
            }
        }
    }
}
