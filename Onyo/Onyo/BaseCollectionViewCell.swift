//
//  BaseCollectionViewCell.swift
//
//
//  Created by Lucas Cypriano on 25/02/16.
//  Copyright © 2016 Lucas Cypriano. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    var scale                : CGFloat = 1.0
    var normalCellWidth      : CGFloat = 0.0
    var normalCellHeight     : CGFloat = 0.0
    var normalWidth          : CGFloat = 0.0
    var normalCellSpacing    : CGFloat = 0.0
    var normalEdgeInsets     : CGFloat = 0.0
    var normalTopEdgeInset   : CGFloat = 0.0
    var normalBottomEdgeInset: CGFloat = 0.0
    var fixedHeigth          : Bool = false
    
    func ratio(frame: CGRect) -> CGFloat {
        
        return CGRectGetWidth(frame)/normalWidth
    }
    
    func cellSize(frame: CGRect) -> CGSize {
        
        let newCellWidth = normalCellWidth * ratio(frame)
        let newCellHeight = normalCellHeight * ratio(frame)
        
        return CGSizeMake(newCellWidth, (fixedHeigth) ? normalCellHeight : newCellHeight)
    }
    
    func interitemSpacing(frame: CGRect) -> CGFloat {
        
        return normalCellSpacing * ratio(frame)
    }
    
    func lineSpacing(frame: CGRect) -> CGFloat {
        
        return normalCellSpacing * ratio(frame)
    }
    
    func edgeInsets(frame: CGRect) -> UIEdgeInsets {
        
        let newEdgeInsets = normalEdgeInsets * ratio(frame)
        return UIEdgeInsetsMake(normalTopEdgeInset, newEdgeInsets, normalBottomEdgeInset, newEdgeInsets)
        
    }

    
}
