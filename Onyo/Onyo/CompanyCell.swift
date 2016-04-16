//
//  CompanyCell.swift
//  Onyo
//
//  Created by Lucas Cypriano on 15/04/16.
//  Copyright © 2016 Lucas Cypriano. All rights reserved.
//

import UIKit
import Kingfisher

class CompanyCell: BaseCollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scale                 = 1.0
        normalCellWidth       = 375 * scale
        normalCellHeight      = 248 * scale
        normalWidth           = 375 //based on a iPhone 6
        normalCellSpacing     = 0.0
        normalEdgeInsets      = 0.0
        normalTopEdgeInset    = 0.0
        normalBottomEdgeInset = 0.0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func cancelImageLoad() {
        imageView.kf_cancelDownloadTask()
    }
    
    //TODO: estimate distance to location
    func setupCell(company: Company, row: NSInteger) {
        
        displayName.text = company.displayName.uppercaseString // +distanceFromGeoLocation
        address.text = company.address.uppercaseString
        backgroundColor = (row % 2 == 0) ? UIColor.whiteColor() : UIColor(red:0.949, green:0.956, blue:0.968, alpha:1)
        activity.hidden = true
    
        //TODO: get the correct image for the collectionView size
        for image in company.image {
            imageView.kf_setImageWithURL(NSURL(string:image.url)!, placeholderImage: nil)
            break
        }
        
    }
}