import UIKit

@IBDesignable
class Header: UIView {
    
    var separator: UIView! = UIView()
    
    @IBInspectable
    var bgColor: UIColor = UIColor.RGB(243.0, g: 245.0, b: 248.0, a: 1.0) {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        separator.frame = CGRectMake(30, frame.size.height-2, frame.size.width - 60, 4)
        separator.backgroundColor = UIColor.RGB(26.0, g: 40.0, b: 61.0, a: 1.0)
    
        self.addSubview(separator!)
    }
}
