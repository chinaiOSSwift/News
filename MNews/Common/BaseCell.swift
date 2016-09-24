//
//  BaseCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    let titleL:UILabel = UILabel()
    let pubDateL:UILabel = UILabel()
    let sourceL:UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /*
         titleL.frame = CGRectMake(10, 10, self.mj_w - 20, self.mj_h - 43) // 默认没有图片
         titleL.backgroundColor = UIColor.redColor()
         titleL.font = UIFont.systemFontOfSize(20)
         titleL.numberOfLines = 0
         self.contentView.addSubview(titleL)
         
         sourceL.frame = CGRectMake(10, titleL.mj_h + titleL.mj_y + 5, 60, 23)
         sourceL.font = UIFont.systemFontOfSize(12)
         sourceL.textAlignment = NSTextAlignment.Center
         self.contentView.addSubview(sourceL)
         
         pubDateL.frame = CGRectMake(sourceL.mj_x + sourceL.mj_w + 5, sourceL.mj_y, 150, 23)
         pubDateL.font = UIFont.systemFontOfSize(12)
         self.contentView.addSubview(pubDateL)
         */
    
    }
    
    func qwer(){
        let labelL = UIView.init(frame: CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height))
        labelL.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(labelL)
        self.bringSubviewToFront(labelL)
    }
    
    func customCellWithModel(model:BaseModel) -> Void{
        
        print("图片数组的个数: \(model.imageurls?.count)")
        let titleL:UILabel = UILabel()
        let pubDateL:UILabel = UILabel()
        let sourceL:UILabel = UILabel()
        if model.imageurls?.first == nil || model.imageurls?.count == 0{ // 没有图片
            print("没有图片")
            titleL.frame = CGRectMake(10, 10, self.mj_w - 20, self.mj_h - 43) // 默认没有图片
//            titleL.backgroundColor = UIColor.redColor()
            titleL.font = UIFont.systemFontOfSize(20)
            titleL.numberOfLines = 0
            sourceL.frame = CGRectMake(10, titleL.mj_h + titleL.mj_y + 5, 60, 23)
            sourceL.font = UIFont.systemFontOfSize(12)
            sourceL.textAlignment = NSTextAlignment.Center
            pubDateL.frame = CGRectMake(sourceL.mj_x + sourceL.mj_w + 5, sourceL.mj_y, 150, 23)
            pubDateL.font = UIFont.systemFontOfSize(12)
        }else {
            if model.imageurls?.count == 1{ // 一张图片
                print("一张图片")
                titleL.frame = CGRectMake(10,5, self.mj_w - 150, self.mj_h - 43)
                let image = UIImageView.init(frame: CGRectMake(titleL.mj_x + titleL.mj_w + 15, 10, 100 - 10, self.mj_h - 15))
                let imageUrl = ((model.imageurls?.first)! as [String:AnyObject])["url"] as! String
                image.sd_setImageWithURL(NSURL.init(string: imageUrl))
                image.contentMode = .ScaleAspectFill
                self.contentView.addSubview(image)
            }else if model.imageurls?.count == 2{ // 两张图片
                print("两张图片")
                let imageW:CGFloat = (Scr_W - 30) / 2
                for i in 0..<Int((model.imageurls?.count)!){
                    let image = UIImageView.init(frame: CGRectMake(10 + (imageW + 10) * CGFloat(i) , 5, imageW - 10, 50))
                    let imageUrl = (model.imageurls![i] as [String:AnyObject])["url"] as! String
                    image.sd_setImageWithURL(NSURL.init(string: imageUrl))
                    self.contentView.addSubview(image)
                }
                titleL.frame = CGRectMake(10, 100, self.mj_w - 20, 20)
                titleL.font = UIFont.systemFontOfSize(17)
                titleL.numberOfLines = 1
                
                sourceL.frame = CGRectMake(10, titleL.mj_h + titleL.mj_y + 2, 60, 17)
                sourceL.font = UIFont.systemFontOfSize(12)
                sourceL.textAlignment = NSTextAlignment.Center
                
                pubDateL.frame = CGRectMake(sourceL.mj_x + sourceL.mj_w + 5, sourceL.mj_y, 150, 17)
                sourceL.font = UIFont.systemFontOfSize(12)
                sourceL.textAlignment = NSTextAlignment.Center
            }else if model.imageurls?.count == 3{ // 三张图片
                print("三张图片")
                let imageW:CGFloat = (Scr_W - 30) / 3
                for i in 0..<Int((model.imageurls?.count)!){
                    let image = UIImageView.init(frame: CGRectMake(10 + (imageW + 10) * CGFloat(i) , 5, imageW - 10, 50))
                    let imageUrl = (model.imageurls![i] as [String:AnyObject])["url"] as! String
                    image.sd_setImageWithURL(NSURL.init(string: imageUrl))
//                    image.backgroundColor = UIColor.redColor()
//                    image.contentMode = .ScaleAspectFill
                    self.contentView.addSubview(image)
                }
                
                titleL.frame = CGRectMake(10, 90, self.mj_w - 20, 20)
                titleL.backgroundColor = UIColor.greenColor()
                titleL.font = UIFont.systemFontOfSize(17)
                titleL.numberOfLines = 1
                
                sourceL.frame = CGRectMake(10, titleL.mj_h + titleL.mj_y + 2, 60, 17)
                sourceL.font = UIFont.systemFontOfSize(12)
                sourceL.textAlignment = NSTextAlignment.Center
                
                pubDateL.frame = CGRectMake(sourceL.mj_x + sourceL.mj_w + 5, sourceL.mj_y, 150, 17)
                sourceL.font = UIFont.systemFontOfSize(12)
                sourceL.textAlignment = NSTextAlignment.Center
            
            }
        }
    
        titleL.text = model.title
        pubDateL.text = model.pubDate
        sourceL.text = model.source
        self.contentView.addSubview(titleL)
        self.contentView.addSubview(sourceL)
        self.contentView.addSubview(pubDateL)
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
