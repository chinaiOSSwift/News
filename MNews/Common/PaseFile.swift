//
//  PaseFile.swift
//  MNews
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


class  PaseFile{
    class func paseFile(articleUrl:String) -> String {
        print(articleUrl)
        var url:String = ""
        /*
         // 下载 路径
         
         // session 网络数据请求
         let session = NSURLSession.sharedSession()
         //将字符串转换成URL 网址类型
         let url = NSURL.init(string: articleUrl)
         // 将网址转换成网络请求
         let request = NSURLRequest.init(URL: url!)
         // 开始网络请求
         */
        
        /*
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            let data = NSData.init(contentsOfURL: NSURL.init(string: articleUrl)!)
            
            let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
            let sourceUrl = obj["sourceUrl"] as! String
            dispatch_async(dispatch_get_main_queue(), {
                url = sourceUrl
            })
        }
        */
        let data = NSData.init(contentsOfURL: NSURL.init(string: articleUrl)!)
        let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        let sourceUrl = obj["sourceUrl"] as! String
        return sourceUrl
        
    }
}

















