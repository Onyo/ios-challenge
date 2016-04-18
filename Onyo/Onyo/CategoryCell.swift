//
//  CategoryCell.swift
//  Onyo
//
//  Created by Lucas Cypriano on 16/04/16.
//  Copyright © 2016 Lucas Cypriano. All rights reserved.
//

import UIKit
import Foundation

class CategoryCell: BaseCollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scale                 = 1.0
        normalCellWidth       = 163 * scale
        normalCellHeight      = 175 * scale
        normalWidth           = 375 //based on a iPhone 6
        normalCellSpacing     = 12.0
        normalEdgeInsets      = 18.0
        normalTopEdgeInset    = 20.0
        normalBottomEdgeInset = 18.0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func cellSize(frame: CGRect) -> CGSize {
        
        let minSize: UInt32 = 175
        let maxSize: UInt32 = 215
        let randHeight = CGFloat(arc4random_uniform(maxSize - minSize)+minSize)
        let newCellWidth = normalCellWidth * ratio(frame)
        let newCellHeight = randHeight * ratio(frame)
        
        return CGSizeMake(newCellWidth, (fixedHeigth) ? normalCellHeight : newCellHeight)
    }

    
    func cancelImageLoad() {
        imageView.kf_cancelDownloadTask()
    }

    func setupCell(category: Category, row: NSInteger) {
        
        name.text = category.name.uppercaseString
        //TODO: get the correct image for the collectionView size
        for image in category.image {
            imageView.kf_setImageWithURL(NSURL(string:image.url)!, placeholderImage: UIImage(named: "category_placeholder"))
            break
        }
        
    }


}
