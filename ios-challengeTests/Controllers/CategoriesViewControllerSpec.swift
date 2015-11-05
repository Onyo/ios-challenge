import Quick
import Nimble
@testable import ios_challenge

class CategoriesViewControllerSpec: QuickSpec {
    
    override func spec() {
        fdescribe("CategoryViewController") {
            
            var categoryViewController: CategoryViewController?
            beforeSuite {
                let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: CategoryViewController.self))
                let viewController = storyboard.instantiateViewControllerWithIdentifier("CategoryViewController")
                categoryViewController = viewController as? CategoryViewController
                categoryViewController?.viewModel = CategoryViewModel(categories: [Categories(numericalId: 10, id: "", name: "Test", parent: nil, menu: nil, brand: nil, order: 1, images: nil)])
            }
            
            fcontext("load view") {
                
                beforeEach {
                    categoryViewController?.view
                }
                
                fit("viewController should not be nil") {
                    expect(categoryViewController).toNot(beNil())
                }
                
                fit("viewController.tableView should not be nil") {
                    expect(categoryViewController?.collectionViewCategories).toNot(beNil())
                }
                
                fit("preferredStatusBarStyle should be eq .Light") {
                    expect(categoryViewController?.preferredStatusBarStyle()).to(equal(UIStatusBarStyle.LightContent))
                }
            }
            
            fcontext("view will appear") {
                
                var collection: UICollectionView?
                beforeEach {
                    categoryViewController?.view
                    categoryViewController?.viewWillAppear(false)
                    collection = categoryViewController?.collectionViewCategories
                }
                
                fit("numberOfItemsInSection should be eq 11") {
                    expect(collection?.numberOfItemsInSection(0)).to(equal(1))
                }
            }
        }
    }
}