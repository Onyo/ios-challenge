import Quick
import Nimble
@testable import ios_challenge

class CompanyViewControllerSpec: QuickSpec {
    
    override func spec() {
        fdescribe("CompanyViewController") {
            
            var viewController: CompanyViewController?
            beforeSuite {
                let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: CompanyViewController.self))
                let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                viewController = navigationController.topViewController as? CompanyViewController
            }
            
            fcontext("load view") {
                
                beforeEach {
                    viewController?.view
                }
                
                fit("viewController should not be nil") {
                    expect(viewController).toNot(beNil())
                }
                
                fit("viewController.tableView should not be nil") {
                    expect(viewController?.tableViewCompany).toNot(beNil())
                }
                
                fit("preferredStatusBarStyle should be eq .Light") {
                    expect(viewController?.preferredStatusBarStyle()).to(equal(UIStatusBarStyle.LightContent))
                }
            }
            
            fcontext("view will appear") {
                
                var table: UITableView?
                beforeEach {
                    viewController?.view
                    viewController?.viewWillAppear(false)
                    table = viewController?.tableViewCompany
                }
                
                fit("numberOfItemsInSection should be greater than or equal to 11") {
                    expect(table?.numberOfRowsInSection(0)).toEventually(beGreaterThanOrEqualTo(10), timeout: 10)
                }
            }
        }
    }
}