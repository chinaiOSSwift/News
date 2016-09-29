//
//  HeadlineCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol ShowDetail:NSObjectProtocol {
    
    // 跳转到webView
    func showDetailView(web:DetailViewController) -> Void
    // 弹出警告框
    func sentMessage(ac:UIAlertController) -> Void
}

class HeadlineCell: BaseCollectionViewCell {
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.channelID = "5572a108b3cdc86cf39001cd"
        self.contentView.backgroundColor = UIColor.whiteColor()
        super.loadData()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}












