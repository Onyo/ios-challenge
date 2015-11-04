import Quick
import Nimble
import Argo
@testable import ios_challenge

class ImagesSpec: QuickSpec {
    
    override func spec() {
        fdescribe("Images ") {
            fcontext("decode json") {
                
                var img: Image?
                let jsonData = "{\"url\": \"http://images.onyo.com/zrtocQtlbobRg0URtawDjb9w0-k=/0x266:1055x1320/fit-in/240x240/https://onyo.s3.amazonaws.com/picture/181e75feeaf0407ebc642b6ae0c53f1c.jpg\",\"width\": 1055,\"context\": \"company-thumbnail-small\",\"height\": 1054}".dataUsingEncoding(NSUTF8StringEncoding)!
                let json = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
                if let j = json {
                    img = decode(j)
                }
                
                fit("width should be eq 1055") {
                    expect(img?.width).to(equal(1055))
                }
                
                fit("width should be eq 1054") {
                    expect(img?.height).to(equal(1054))
                }
                
                fit("image context should be eq background") {
                    expect(img?.context).to(equal(ImageContext.Small))
                }
            }
        }
    }
}
