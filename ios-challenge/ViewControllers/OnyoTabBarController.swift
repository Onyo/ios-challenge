import UIKit

enum Tab: Int {
    case TabBarHome = 0
    case TabBarCardapio = 1
    case TabBarRedeem = 2
}

class OnyoTabBarController: UITabBarController {

    var categoryViewModel: CategoryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: UIImage(asset: .LogoBaked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(asset: .Onyo)))
    }
    
    func selectTab(tab: Tab) {
        switch tab {
        case .TabBarCardapio:
            (self.viewControllers?[tab.rawValue] as! CategoryViewController).viewModel = self.categoryViewModel
        default: break
        }
        
        self.selectedIndex = tab.rawValue
    }
}
