//
//  MeCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {

    
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
