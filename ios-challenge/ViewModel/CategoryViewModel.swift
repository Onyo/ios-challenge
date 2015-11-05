import Foundation
import RxSwift

class CategoryViewModel {
    
    private var categories: [Categories]
    
    init(categories: [Categories]) {
        self.categories = categories
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    func numberOfCategoriesByRow() -> Int {
        return 2
    }
    
    func categoryAtIndex(index: Int) ->  Categories {
        return categories[index]
    }
    

}