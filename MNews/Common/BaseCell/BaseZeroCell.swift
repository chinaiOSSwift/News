//
//  BaseZeroCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BaseZeroCell: UITableViewCell {

    
    
    @IBOutlet weak var titleL: UILabel!
    
    
    @IBOutlet weak var sourceL: UILabel!
    
    @IBOutlet weak var pubDateL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func customCellWithDic(model:BaseModel) -> Void {
        titleL.text = model.title
        sourceL.text = model.source
        pubDateL.text = model.pubDate
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
