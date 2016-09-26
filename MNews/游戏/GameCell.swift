//
//  GameCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class GameCell: BaseCollectionViewCell {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.channelID = "5572a10ab3cdc86cf39001ee"
        self.contentView.backgroundColor = UIColor.whiteColor()
        super.loadData()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
