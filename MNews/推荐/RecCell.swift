//
//  RecCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class RecCell: BaseCollectionViewCell {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.channelID = "5572a109b3cdc86cf39001de"
        self.contentView.backgroundColor = UIColor.whiteColor()
        super.loadData()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}









