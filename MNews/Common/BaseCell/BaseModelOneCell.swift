//
//  BaseModelOneCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BaseModelOneCell: UITableViewCell {

    
    
    @IBOutlet weak var titleL: UILabel!
    
    
    @IBOutlet weak var sourceL: UILabel!
    
    @IBOutlet weak var pubDateL: UILabel!
    
    
    @IBOutlet weak var imageView1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func customCellWithModel(model:BaseModel) -> Void {
        let imageUrl = (model.imageurls!.first)!["url"] as! String
        imageView1.sd_setImageWithURL(NSURL.init(string: imageUrl))
        titleL.text = model.title
        sourceL.text = model.source
        pubDateL.text = model.pubDate
        
    }
    
    
    
    
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
