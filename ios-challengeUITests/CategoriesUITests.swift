import XCTest
@testable import ios_challenge

class CategoriesUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShoulOpenListCategories() {
        let app = XCUIApplication()
        let table = app.tables.elementBoundByIndex(0)
        
        table.cells.elementBoundByIndex(0).tap()
        
        let header = app.searchFields["CATEGORIES"]
        
        let collectionView = app.otherElements.containingType(.NavigationBar, identifier:"ios_challenge.OnyoTabBar").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.CollectionView).element
        collectionView.swipeUp()
        collectionView.swipeUp()
        
        XCTAssertNotNil(header)
        XCTAssertGreaterThanOrEqual(collectionView.cells.count, 3)
    }
}
