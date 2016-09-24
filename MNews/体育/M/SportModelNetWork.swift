
//
//  SportModelNetWork.swift
//  MNews
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

extension SportModel{
    class func  requestDtat(HOME_URL httpUrl: String, httpArg: String,callBack:(array:[AnyObject]?,error:NSError?) -> Void)->Void {
        let req = NSMutableURLRequest(URL: NSURL(string: httpUrl + "?" + httpArg)!)
        req.timeoutInterval = 6
        req.HTTPMethod = "GET"
        req.addValue(apikey, forHTTPHeaderField: "apikey")
//        print("请求的网址: \(req)")
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) -> Void in
            if error == nil{
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let array = obj["newslist"] as? [AnyObject]
                var models:NSMutableArray? = nil
                do {
                    models = try SportModel.arrayOfModelsFromDictionaries(array,error: ())
                }catch{
                    models = NSMutableArray()
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: models! as [AnyObject], error: nil)
                })
            
            }else{
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil, error: error)
                })
            }
        }
    }
    
}
























