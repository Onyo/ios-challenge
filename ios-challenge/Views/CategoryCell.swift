import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet var lblCategoryName: UILabel!
    @IBOutlet var imgCategory: UIImageView!
    
    func populateCategory(category: Categories) {
        self.lblCategoryName.text = category.name
        loadImage(category.images)
    }
    
    private func loadImage(images: [Image]?) {
        let imageMedium = images?.filter({ $0.context == ImageContext.Background }).first
        if let img = imageMedium, let imgUrl = img.url {
            self.imgCategory.load(imgUrl)
        }
    }
}
