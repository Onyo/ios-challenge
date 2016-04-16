import Foundation
import UIKit

extension UIImage {
    enum Asset : String {
        case LogoBaked = "logo_baked"
        case Onyo = "onyo"
        
        var image: UIImage {
            return UIImage(asset: self)
        }
    }
    
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}