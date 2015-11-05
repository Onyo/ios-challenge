import XCTest
@testable import ios_challenge

class CompanyUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldListCompanies() {
        let app = XCUIApplication()
        let header = app.searchFields["CHOOSE YOUR RESTAURANT"]
        
        XCTAssertNotNil(header)
        
        let table = app.tables.elementBoundByIndex(0)
        table.swipeUp()
        table.swipeUp()

        XCTAssertGreaterThanOrEqual(table.cells.count, 10)
    }
}
