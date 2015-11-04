import Quick
import Nimble
import Argo
@testable import ios_challenge

class CompanySpec: QuickSpec {
    
    override func spec() {
        fdescribe("Company") {
            fcontext("decode json") {
                
                var company: Company?
                let jsonData = "{\"numericalId\": 10,\"geoLat\": \"-22.9869756000\",\"name\": \"Gula Gula Leblon\",\"displayName\": \"Leblon\",\"address\": \"Av. Gen. San Martin, 1196 Esquina Rua Rita Ludolf, Leblon - Rio de Janeiro, RJ - 22441-014\",\"menu\": \"http://api.staging.onyo.com/v1/mobile/menu/1\",\"brand\": \"http://api.staging.onyo.com/v1/mobile/brand/1\",\"geoLon\": \"-43.2276571000\",\"id\": \"http://api.staging.onyo.com/v1/mobile/company/10\",\"image\": [{\"url\": \"http://images.onyo.com/zrtocQtlbobRg0URtawDjb9w0-k=/0x266:1055x1320/fit-in/240x240/https://onyo.s3.amazonaws.com/picture/181e75feeaf0407ebc642b6ae0c53f1c.jpg\",\"width\": 1055,\"context\": \"company-thumbnail-small\",\"height\": 1054},{\"url\": \"http://images.onyo.com/4FKFjm9DEtRkv8Kol1Nynk1wCCQ=/0x307:1055x1314/fit-in/408x390/https://onyo.s3.amazonaws.com/picture/69c70e6722324419bab364166f7596cd.jpg\",\"width\": 1055,\"context\": \"company-thumbnail-medium\",\"height\": 1007},{\"url\": \"http://images.onyo.com/yPZuOF2XaMKz4f2iPEZG0GWJqYY=/0x254:2224x1497/fit-in/912x510/https://onyo.s3.amazonaws.com/picture/594ce255888d45899b6f32f16c7ee64c.jpg\",\"width\": 2224,\"context\": \"company-main\",\"height\": 1243}]}".dataUsingEncoding(NSUTF8StringEncoding)!
                let json = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
                if let j = json {
                    company = decode(j)
                }

                fit("numericalId should be eq 10") {
                    expect(company?.numericalId).to(equal(10))
                }
                
                fit("name should be eq Gula Gula Leblon") {
                    expect(company?.name).to(equal("Gula Gula Leblon"))
                }
                
                fit("name should be eq Av. gen...") {
                    expect(company?.address).to(equal("Av. Gen. San Martin, 1196 Esquina Rua Rita Ludolf, Leblon - Rio de Janeiro, RJ - 22441-014"))
                }
                
                fit("count of images should be eq 3") {
                    expect(company?.images?.count).to(equal(3))
                }
            }
            
            fcontext("List comanies") {
                
                var company: CompanySummary?
                let jsonData = "{\"numericalId\": 1,\"name\": \"Gula Gula\",\"companies\": [{\"numericalId\": 10,\"geoLat\": \"-22.9869756000\",\"name\": \"Gula Gula Leblon\",\"displayName\": \"Leblon\",\"address\": \"Av. Gen. San Martin, 1196 Esquina Rua Rita Ludolf, Leblon - Rio de Janeiro, RJ - 22441-014\",\"menu\": \"http://api.staging.onyo.com/v1/mobile/menu/1\",\"brand\": \"http://api.staging.onyo.com/v1/mobile/brand/1\",\"geoLon\": \"-43.2276571000\",\"id\": \"http://api.staging.onyo.com/v1/mobile/company/10\",\"image\": [{\"url\": \"http://images.onyo.com/zrtocQtlbobRg0URtawDjb9w0-k=/0x266:1055x1320/fit-in/240x240/https://onyo.s3.amazonaws.com/picture/181e75feeaf0407ebc642b6ae0c53f1c.jpg\",\"width\": 1055,\"context\": \"company-thumbnail-small\",\"height\": 1054},{\"url\": \"http://images.onyo.com/4FKFjm9DEtRkv8Kol1Nynk1wCCQ=/0x307:1055x1314/fit-in/408x390/https://onyo.s3.amazonaws.com/picture/69c70e6722324419bab364166f7596cd.jpg\",\"width\": 1055,\"context\": \"company-thumbnail-medium\",\"height\": 1007},{\"url\": \"http://images.onyo.com/yPZuOF2XaMKz4f2iPEZG0GWJqYY=/0x254:2224x1497/fit-in/912x510/https://onyo.s3.amazonaws.com/picture/594ce255888d45899b6f32f16c7ee64c.jpg\",\"width\": 2224,\"context\": \"company-main\",\"height\": 1243}]}]}".dataUsingEncoding(NSUTF8StringEncoding)!
                let json = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
                if let j = json {
                    company = decode(j)
                }
                
                fit("numericalId should be eq 1") {
                    expect(company?.numericalId).to(equal(1))
                }
                
                fit("name should be eq Gula Gula") {
                    expect(company?.name).to(equal("Gula Gula"))
                }
                
                fit("count should be eq 1") {
                    expect(company?.companies?.count).to(equal(1))
                }
                
                fit("numericalId of first company should be eq 10") {
                    expect(company?.companies?.first?.numericalId).to(equal(10))
                }
            }
        }
    }
}
