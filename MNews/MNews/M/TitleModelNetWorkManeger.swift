//
//  TitleModelNetWorkManeger.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

extension TitleModel{
    class func requestTitleData(callBack:(titleArr:[AnyObject]?,error:NSError?)->Void)->Void {
       
        let url = "http://reader.meizu.com/android/unauth/v2700/columns/subscribe.do?supportSDK=16&videoVersion=573&v=2820&operator=46007&nt=wifi&vn=2.8.20&deviceinfo=abkKGK7stpDVHr%2BU5eDCI4RjsMe3210ffOmrxhTgUhxSKX%2FYvzyGM93ltRtHOHfOc6WCkzYaYdQ2hi32V%2F5HCf4dbeX8UakuBEZ%2Fda1f2MWPTukgOEXJcXpV4BibUEV6FB35RQPfr32RBcKvZodQHD3Nt%2FIn%2FWvJ3IZA9IreqYc%3D&os=5.1-1469416338_stable"
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
//            let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding)
//            print(str!)
            if error == nil{
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let titles = obj["value"]!["columnSubscribes"] as? [AnyObject]
                var models:NSMutableArray?
                do{
                    models = try TitleModel.arrayOfModelsFromDictionaries(titles,error: ())
                    
                }catch{
                    models = NSMutableArray()
                }
                // 回到主线程
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(titleArr: models! as [AnyObject], error: nil)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(titleArr: nil,error: error)
                })
            }
            
        }
    }
    
}




















