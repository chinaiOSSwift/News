//
//  EnterModelNetWork.swift
//  MNews
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

extension EnterModel{
    class func requestData(url:String, callBack:(array:[AnyObject]?,idArray:[String]?, error: NSError?) -> Void) -> Void {
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
            if error == nil{
                //                let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding)
                //                print(str!)
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                let dic = obj["data"]!["articles"] as! NSDictionary
                
                let keys = dic.allKeys as! [String]
                
                //                RecModel.arrayOfModelsFromDictionaries(<#T##array: [AnyObject]!##[AnyObject]!#>)
                
                var models = [EnterModel]()
                for key in keys{
                    let model = EnterModel()
                    let eachDic = dic[key] as! NSDictionary
                    model.cmtUrl = eachDic["cmt_url"] as! String
                    model.id = eachDic["id"] as! String
                    model.sourceName = eachDic["source_name"] as! String
                    model.title = eachDic["title"] as! String
                    model.url = eachDic["url"] as! String
                    model.zzdUrl = eachDic["zzd_url"] as! String
                    let array = eachDic["images"] as! NSArray
                    if array.count != 0{
                        model.originalUrl = (array.firstObject as! NSDictionary)["original_url"] as! String
                        model.imageUrl = (array.firstObject as! NSDictionary)["url"] as! String
                    }
                    models.append(model)
                }
                // id数组
                let ids = obj["data"]!["remove_ids"] as! [String]
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: models,idArray: ids,error: nil)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: nil,idArray: nil,error: error)
                })
            }
        }
    }
}

