import UIKit
import ImageLoader

class CompanyViewController: UIViewController, CompanyViewModelDelegate {

    @IBOutlet var tableViewCompany: UITableView!
    
    var viewModel: CompanyViewModel!
    var categoryViewModel: CategoryViewModel!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image: UIImage(asset: .LogoBaked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(asset: .Onyo)))
        
        configureRefreshControl()
        viewModel = CompanyViewModel(delegate: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        refreshCompanies()
    }
    
    func refreshCompanies() {
        viewModel.refresh()
    }
    
    // MARK: - UI Methods
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl.addTarget(self, action: "refreshCompanies", forControlEvents: .ValueChanged)
        tableViewCompany.addSubview(refreshControl)
    }
    
    func beginLoading() {
        refreshControl.beginRefreshing()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
    }
    
    func endLoading() {
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshed at \(NSDate().timeAgo)")
        refreshControl.endRefreshing()
    }
    
    func showErrorOnRefresh(message: String?){
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .Alert)
        let actionOk = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(actionOk)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: View model delegate
    func refreshCompleted() {
        tableViewCompany.reloadData()
        self.endLoading()
    }
    
    func refreshError(error: ApiError?) {
        self.endLoading()
        
        switch error {
        case .FailureRequest(_, let apiResponse)?:
            showErrorOnRefresh(apiResponse?.message)
        default: break
        }
    }
}

// MARK: Navigation
extension CompanyViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueIdentifier = SegueIdentifier(rawValue: segue.identifier!) {
            switch segueIdentifier {
            case .SegueToCategories:
                let tabBarController = segue.destinationViewController as! OnyoTabBarController
                tabBarController.categoryViewModel = self.categoryViewModel
                tabBarController.selectTab(.TabBarCardapio)
            }
        }
    }
}
