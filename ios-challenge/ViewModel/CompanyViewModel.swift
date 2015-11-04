import Foundation
import RxSwift

protocol CompanyViewModelDelegate {
    func refreshCompleted()
    func refreshError(error: ApiError?)
}

class CompanyViewModel {
    
    private var delegate: CompanyViewModelDelegate?
    private lazy var disposeBag = DisposeBag()
    private var companies: [Company] = []
    
    init(delegate: CompanyViewModelDelegate) {
        self.delegate = delegate
    }
    
    func refresh() {
        CompanyApi.companies()
            .subscribe({ (event) -> Void in
                switch event {
                case .Next(let company):
                    self.refreshCompanyList(company.companies)
                case .Error(let error):
                    self.delegate?.refreshError(error as? ApiError)
                case .Completed:
                    self.delegate?.refreshCompleted()
                }
            })
            .addDisposableTo(self.disposeBag)
    }
    
    func numberOfCompanies() -> Int {
        return companies.count
    }
    
    func companyByIndex(index: Int) ->  Company {
        return companies[index]
    }
    
    private func refreshCompanyList(companies: [Company]?) {
        if let companyList = companies {
            for company in companyList {
                if !self.companies.contains({ ($0.numericalId) == company.numericalId }) {
                    self.companies.insert(company, atIndex: self.companies.count)
                }
            }
        }
        
        self.delegate?.refreshCompleted()
    }
}