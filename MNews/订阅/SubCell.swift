//
//  SubCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SubCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
