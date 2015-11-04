import UIKit
import ImageLoader

class CompanyViewController: UIViewController, CompanyViewModelDelegate {

    @IBOutlet var tableViewCompany: UITableView!
    
    var viewModel: CompanyViewModel!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRefreshControl()
        viewModel = CompanyViewModel(delegate: self)

        self.navigationItem.titleView = UIImageView(image: UIImage(asset: .LogoBaked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(asset: .Onyo)))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        viewModel.refresh()
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
        refreshControl.addTarget(self, action: "refreshCompanies", forControlEvents: UIControlEvents.ValueChanged)
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

extension CompanyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfCompanies()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellCompany", forIndexPath: indexPath) as! CompanyCell
        
        cell.backgroundColor(indexPath)
        cell.populateCompany(self.viewModel.companyByIndex(indexPath.row))
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
