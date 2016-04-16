import UIKit

extension CompanyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfCompanies()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellCompany", forIndexPath: indexPath) as! CompanyCell
        
        cell.backgroundColor(indexPath)
        cell.populateCompany(self.viewModel.companyAtIndex(indexPath.row))
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let categories = self.viewModel.companySummary().categories {
            self.categoryViewModel = CategoryViewModel(categories: categories)
            performSegueWithIdentifier(SegueIdentifier.SegueToCategories.rawValue, sender: nil)
        }
    }
}