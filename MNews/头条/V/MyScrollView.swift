//
//  MyScrollView.swift
//  zSVLoop
//
//  Created by huanghailong on 16/8/11.
//  Copyright © 2016年 huanghailong. All rights reserved.
//

import UIKit

// 传一个模型数组
class MyScrollView: UIScrollView, UIScrollViewDelegate {

    var nameArr: [String]!
    
    init(frame: CGRect, arr: [String]?, isTimer: Bool = false) {
        super.init(frame: frame)
        
        if arr == nil {
            return
        }
        
        nameArr = arr
        nameArr.insert(nameArr[nameArr.count - 1], atIndex: 0)
        nameArr.append(nameArr[1])
        
        var rect = frame
        for i in 0..<nameArr.count {
            rect.origin.x = frame.size.width * CGFloat(i)
            rect.origin.y = 0
            // 添加图片
            let iv = UIImageView.init(frame: rect)
            ////////////////////////////////////
            iv.sd_setImageWithURL(NSURL.init(string: nameArr[i] ))
            self.addSubview(iv)
            
            // 添加 titleL
            
            
            
        }
        self.contentSize = CGSize.init(width: Int(frame.width) * nameArr.count, height: 0)
        self.contentOffset = CGPointMake(frame.width, 0)
        self.pagingEnabled = true
        self.delegate = self
        
        if isTimer == false {
            return
        }
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(self.timeRun), userInfo: nil, repeats: true)
    }
    
    func timeRun() -> Void {
        var page = Int(self.contentOffset.x / self.frame.width)
        print("contentOff.x = \(self.contentOffset.x) width = \(self.frame.width) page = \(page) page + 1 = \(page + 1) nameArr.count = \(nameArr.count)")
        page += 1
        if page == nameArr.count - 1 { // nameArr.count = 6; 4 1 2 3 4 1 如果page + 1  = 5 说明当前图片编号是4 即是第0偏移量
            self.contentOffset = CGPointZero
            page = 1
        }
        // 依次往后循环比较(每一都是比较下一张) 知道第4张
        self.setContentOffset(CGPointMake(CGFloat(page) * self.frame.width, 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {  // nameArray.count = 6 如果偏移量是0 :  4 1 2 3 4 1 说明当前图片编号是4 即 4 个偏移量(nameArr.count  -  2)
            scrollView.contentOffset = CGPointMake(CGFloat(nameArr.count - 2) * scrollView.frame.width, 0)
        } else if scrollView.contentOffset.x == CGFloat(nameArr.count - 1) * scrollView.frame.width {
            // 如果偏移量是 5 个,说明当前图片编号是1, 即一个偏移量
            scrollView.contentOffset = CGPointMake(scrollView.frame.width, 0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

























