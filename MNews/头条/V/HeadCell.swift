//
//  HeadCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HeadCell: UITableViewCell {

    
    
    @IBOutlet weak var contentCountL: UILabel!
 
   
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var sourceNameL: UILabel!
    
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
