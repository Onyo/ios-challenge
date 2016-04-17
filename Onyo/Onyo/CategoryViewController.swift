//
//  CategoryViewController.swift
//  Onyo
//
//  Created by Lucas Cypriano on 16/04/16.
//  Copyright © 2016 Lucas Cypriano. All rights reserved.
//

import Foundation
import SVProgressHUD
import CHTCollectionViewWaterfallLayout

private let nib = "CategoryCell"
private let reuseIdentifier = "categoryCell"

class CategoryViewController: UICollectionViewController, CHTCollectionViewDelegateWaterfallLayout {
    
    var menu      :  Menu?
    var dataSource:  [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        collectionView?.backgroundColor = UIColor(red:0.949, green:0.956, blue:0.968, alpha:1)
        Model().getCategoriesOrderedForMenu(menu!)
        dataSource = Model().getCategoriesOrderedForMenu(menu!)!
        //TODO: setup navigationBar according to the preview
        title = "Catigorias"
        
    }

    func setupCollectionView() {
        
        // Create a waterfall layout
        let layout = CHTCollectionViewWaterfallLayout()
        
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 12.0
        layout.minimumInteritemSpacing = 12.0
        layout.headerHeight = 12.0
        layout.footerHeight = 12.0
        layout.sectionInset = CategoryCell().edgeInsets(view.frame)
        
        // Collection view attributes
        collectionView?.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        collectionView?.alwaysBounceVertical = true
        
        // Add the waterfall layout to your collection view
        collectionView?.collectionViewLayout = layout
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerNib(UINib(nibName: nib, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        //collectionView?.setCollectionViewLayout(setupFlowLayout(), animated: false)
    }
    
    func setupFlowLayout() -> UICollectionViewFlowLayout{
        
        //Setup flowLayout according to its UIColloectionViewCell parameters
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CategoryCell().cellSize(view.frame)
        layout.minimumInteritemSpacing = CategoryCell().interitemSpacing(view.frame)
        layout.minimumLineSpacing = CategoryCell().lineSpacing(view.frame)
        layout.sectionInset = CategoryCell().edgeInsets(view.frame)
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
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CategoryCell
        cell.setupCell(dataSource[indexPath.row], row:indexPath.row)
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = cell as! CategoryCell
        cell.cancelImageLoad()
        
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CategoryCell().cellSize(view.frame)
    }

}
