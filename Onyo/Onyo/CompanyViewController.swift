//
//  ViewController.swift
//  Onyo
//
//  Created by Lucas Cypriano on 14/04/16.
//  Copyright © 2016 Lucas Cypriano. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

private let nibName = "CompanyCell"
private let reuseIdentifier = "companyCell"

class CompanyViewController: UICollectionViewController {
    
    var dataSouce: [Company] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCompanyData()
        setupCollectionView()
        
        //TODO: setup navigationBar according to the preview
        title = "Baked Potato"
        
    }
    
    //TODO: show progress
    //TODO: move it to the correct class
    func loadCompanyData() {
        
        let URL = "http://api.staging.onyo.com/v1/mobile/brand/1/company"
        Alamofire.request(.GET, URL).responseArray(keyPath: "companies") { (response: Response<[Company], NSError>) in
            
            let companyArray = response.result.value
            
            if let companyArray = companyArray {
                
                self.dataSouce = companyArray
                self.collectionView?.reloadData()
                
            }
        }
    }
    
    func setupCollectionView() {
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerNib(UINib(nibName: "CompanyCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
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
        return dataSouce.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CompanyCell
        
        cell.setupCell(dataSouce[indexPath.row], row:indexPath.row)
        
        return cell
        
    }
}

