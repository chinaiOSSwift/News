//
//  ScienceCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ScienceCell: UICollectionViewCell {
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.greenColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
