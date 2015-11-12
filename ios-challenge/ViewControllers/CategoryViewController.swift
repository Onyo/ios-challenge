import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet var collectionViewCategories: UICollectionView!
    
    var viewModel: CategoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.collectionViewCategories.reloadData()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
