//
//  MyScrollView.swift
//  zSVLoop
//
//  Created by huanghailong on 16/8/11.
//  Copyright © 2016年 huanghailong. All rights reserved.
//

import UIKit

protocol ChangeCurrentPage:NSObjectProtocol {
    func changePage(page:Int) -> Void
}

// 传一个模型数组
class MyScrollView: UIScrollView, UIScrollViewDelegate {

    var nameArr:[BannerModel]!
    weak var delegator:ChangeCurrentPage?
    var currentPage:Int?
    init(frame: CGRect, arr: NSArray?, isTimer: Bool = false) {
        super.init(frame: frame)
        
        if arr == nil {
            return
        }
        nameArr = arr as! [BannerModel]
        nameArr.insert(nameArr[nameArr.count - 1], atIndex: 0)
        nameArr.append(nameArr[1])
        
        var rect = frame
        for i in 0..<nameArr.count {
            rect.origin.x = frame.size.width * CGFloat(i)
            rect.origin.y = 0
            // 添加图片
            let iv = UIImageView.init(frame: rect)
            
            iv.userInteractionEnabled = true
            iv.tag = 100 + i
            let tapped = UITapGestureRecognizer.init(target: self, action: #selector(self.tapClick(_:)))
            iv.addGestureRecognizer(tapped)
            
            var imageURL = (nameArr[i].imgUrlList?.lastObject) as? String
            
            if imageURL == nil{
                imageURL = nameArr[i].vScreenImg
            }
//            print(imageURL!)
            iv.sd_setImageWithURL(NSURL.init(string: imageURL!))
            
            // 添加 titleL
            let titleL = UILabel.init(frame: CGRectMake(0, iv.mj_h - 40, iv.mj_w, 20))
            titleL.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
            titleL.textAlignment = NSTextAlignment.Center
            titleL.font = UIFont.systemFontOfSize(18)
            var title = nameArr[i].title
            if title == ""{
                title = nameArr[i].vTitle
            }
            titleL.text = title
            iv.addSubview(titleL)
            self.addSubview(iv)
        }
        self.contentSize = CGSize.init(width: Int(frame.width) * nameArr.count, height: 0)
        self.contentOffset = CGPointMake(frame.width, 0)
        self.pagingEnabled = true
        self.delegate = self
        
        if isTimer == false {
            return
        }
        currentPage = 0
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.timeRun), userInfo: nil, repeats: true)
    }
    
    // MARKL:- 图片点击方法
    func tapClick(tap:UITapGestureRecognizer) -> Void {
       let index = (tap.view!.tag) - 100
       print(nameArr[index].title)
        
        // 能拿到model
    }
    
    
    
    
    func timeRun() -> Void {
        var page = Int(self.contentOffset.x / self.frame.width)
//        print("contentOff.x = \(self.contentOffset.x) width = \(self.frame.width) page = \(page) page + 1 = \(page + 1) nameArr.count = \(nameArr.count)")
        page += 1
        if page == nameArr.count - 1 { // nameArr.count = 6; 4 1 2 3 4 1 如果page + 1  = 5 说明当前图片编号是4 即是第0偏移量
            self.contentOffset = CGPointZero
            page = 1
        }
        // 依次往后循环比较(每一都是比较下一张) 知道第4张
        self.setContentOffset(CGPointMake(CGFloat(page) * self.frame.width, 0), animated: true)
        // 调用代理方法
        self.currentPage = lrint(Double(self.contentOffset.x) / Double(self.frame.width))
        self.delegator?.changePage(currentPage! + 1)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {  // nameArray.count = 6 如果偏移量是0 :  4 1 2 3 4 1 说明当前图片编号是4 即 4 个偏移量(nameArr.count  -  2)
            scrollView.contentOffset = CGPointMake(CGFloat(nameArr.count - 2) * scrollView.frame.width, 0)
        } else if scrollView.contentOffset.x == CGFloat(nameArr.count - 1) * scrollView.frame.width {
            // 如果偏移量是 5 个,说明当前图片编号是1, 即一个偏移量
            scrollView.contentOffset = CGPointMake(scrollView.frame.width, 0)
        }
        self.currentPage = lrint(Double(scrollView.contentOffset.x) / Double(scrollView.frame.width))
        self.delegator?.changePage(currentPage!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

























