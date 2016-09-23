//
//  SciCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SciCell: UITableViewCell {

    
    @IBOutlet weak var titleL: UILabel!
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var contentSourceL: UILabel!
    
    @IBOutlet weak var contentCountL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
