//
//  BaseModelTwoCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BaseModelTwoCell: UITableViewCell {

    
    
    @IBOutlet weak var imageView1: UIImageView!
    
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var titleL: UILabel!
    
    
    @IBOutlet weak var sourceL: UILabel!
    
    @IBOutlet weak var pubDateL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func customCellWithModel(model:BaseModel) -> Void {
        let imageUrl1 = ((model.imageurls?.first)! as NSDictionary)["url"] as! String
        let imageUrl2 = (model.imageurls![1] as NSDictionary)["url"] as! String
        imageView1.sd_setImageWithURL(NSURL.init(string: imageUrl1))
        imageView2.sd_setImageWithURL(NSURL.init(string: imageUrl2))
        titleL.text = model.title
        sourceL.text = model.source
        pubDateL.text = model.pubDate
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
