import Quick
import Nimble
import Argo
@testable import ios_challenge

class CategoriesSpec: QuickSpec {
    
    override func spec() {
        fdescribe("Category ") {
            fcontext("decode json") {
                
                var cat: Categories?
                let jsonData = "{\"numericalId\": 30,\"name\": \"Gula Café\",\"parent\": null,\"menu\": \"http://api.staging.onyo.com/v1/mobile/menu/1\",\"brand\": \"http://api.staging.onyo.com/v1/mobile/brand/1\",\"image\": [{\"url\": \"http://images.onyo.com/er8KYxvPkQkdezK4XlkGa3loRYU=/0x0:450x480/fit-in/450x480/https://onyo.s3.amazonaws.com/picture/a8dfb503f4784e8b9b135a980c7c85d9.png\",\"width\": 450,\"context\": \"category-background\",\"height\": 480}],\"id\": \"http://api.staging.onyo.com/v1/mobile/category/30\",\"order\": 11}".dataUsingEncoding(NSUTF8StringEncoding)!
                let json = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
                if let j = json {
                    cat = decode(j)
                }

                fit("numericalId should be eq 30") {
                    expect(cat?.numericalId).to(equal(30))
                }

                fit("name should be eq Gula Café") {
                    expect(cat?.name).to(equal("Gula Café"))
                }

                fit("count of images should be eq 1") {
                    expect(cat?.images?.count).to(equal(1))
                }
                
                fit("image context should be eq background") {
                    expect(cat?.images?.first?.context).to(equal(ImageContext.Background))
                }
            }
        }
    }
}
