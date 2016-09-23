//
//  FunModelNetWork.swift
//  MNews
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


extension FunModel {
    
    class func requestFunnyData(url:String,callBack:(array:[AnyObject]?,error: NSError?) -> Void) ->Void{
        //http://reader.meizu.com/android/unauth/columns/article/refresh.do?lastTime=1474630942000&articleId=122810012&columnId=16&v=2820&operator=46007&nt=wifi&vn=2.8.20&deviceinfo=nf20aYY90msjwjdXbxMs%2FZl2YisjxIaBlgSiOEdgTVxB5rRD%2FUFp8AjQ%2B0V%2BojbouilyV0zqw9D7PtsLHyTK6kfjOKY9PSS7iVioPzuyXdDfAAshGboGZgsUbZ2VsV7Xsj6KuSGGT9pl7DzzyDHL4bHkSdCm1dyx2LrGluda2no%3D&os=5.1-1469416338_stable
        
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
            if error == nil{
//                let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding)
//                print(str!)
                
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let array = (obj["value"] as! NSDictionary)["articles"] as! [[String:AnyObject]]
                var models = [FunModel]()
                for each in array{
                    let model = FunModel()
                    model.articleId = each["articleId"] as! NSNumber
                    model.articleUrl = each["articleUrl"] as! String
                    model.commentCount = each["commentCount"] as! NSNumber
                    model.Description = each["description"] as! String
                    model.imgUrlList = each["imgUrlList"] as? NSArray
                    model.contentSourceName = each["contentSourceName"] as! String
                    model.pv = each["pv"] as! NSNumber
                    model.title = each["title"] as! String
                    models.append(model)
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: models, error: nil)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil, error: error)
                })
            }
        }
    }
}











