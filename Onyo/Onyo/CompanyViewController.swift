//
//  ViewController.swift
//  Onyo
//
//  Created by Lucas Cypriano on 14/04/16.
//  Copyright © 2016 Lucas Cypriano. All rights reserved.
//

import UIKit
import SVProgressHUD

private let nib = "CompanyCell"
private let reuseIdentifier = "companyCell"

class CompanyViewController: UICollectionViewController {
    
    var dataSource:  [Company] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupCollectionView()
        
        self.dataSource = Model().getCompanies()
        
        //TODO: setup navigationBar according to the preview
        title = "Baked Potato"
        
    }
    
    func loadData() {
       
        SVProgressHUD.show()
        Connection().loadData({ [unowned self] (objectList) in
            
            SVProgressHUD.dismiss()
            self.dataSource = objectList as! [Company]
            self.collectionView!.reloadData()
            
            }) { (error) in
                
                //TODO: should show an error in case there's no cache...
                SVProgressHUD.dismiss()
        }
    }
    
    func setupCollectionView() {
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerNib(UINib(nibName: nib, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.setCollectionViewLayout(setupFlowLayout(), animated: false)
    }
    
    func setupFlowLayout() -> UICollectionViewFlowLayout{
        
        //Setup flowLayout according to its UIColloectionViewCell parameters
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CompanyCell().cellSize(view.frame)
        layout.minimumInteritemSpacing = CompanyCell().interitemSpacing(view.frame)
        layout.minimumLineSpacing = CompanyCell().lineSpacing(view.frame)
        layout.sectionInset = CompanyCell().edgeInsets(view.frame)
        
        return layout
        
    }
    
    //MARK: - UICollectionView Delegate/DataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CompanyCell
        cell.setupCell(dataSource[indexPath.row], row:indexPath.row)
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = cell as! CompanyCell
        cell.cancelImageLoad()
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let company = dataSource[indexPath.row]
        if let menu = Model().getMenuWithId(company.menuOnId) {
            Model().updateMenu(menu)
            performSegueWithIdentifier("TabBarSegue", sender: menu)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let categoryViewController = segue.destinationViewController as! CategoryViewController
        let menu = sender as! Menu
        categoryViewController.menu = menu
        
    }
}

