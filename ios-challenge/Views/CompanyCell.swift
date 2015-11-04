import UIKit

class CompanyCell: UITableViewCell {

    @IBOutlet var imageViewContent: UIView!
    @IBOutlet var imgCompany: UIImageView!
    @IBOutlet var lblDisplayName: UILabel!
    @IBOutlet var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func backgroundColor(indexPath: NSIndexPath) {
        if indexPath.row % 2 != 0 {
            self.backgroundColor = UIColor.RGB(243.0, g: 245.0, b: 248.0, a: 1.0)
        } else {
            self.backgroundColor = UIColor.whiteColor()
        }
    }
    
    func populateCompany(company: Company) {
        self.lblDisplayName.text = company.displayName
        self.lblAddress.text = company.address
        loadImage(company.images)
    }
    
    private func loadImage(images: [Image]?) {
        let imageMedium = images?.filter({ $0.context == ImageContext.Medium }).first
        if let img = imageMedium, let imgUrl = img.url {
            self.imgCompany.load(imgUrl)
        }
    }
}
