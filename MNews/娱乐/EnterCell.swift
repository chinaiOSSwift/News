//
//  EnterCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class EnterCell: UICollectionViewCell {
    
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.orangeColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
