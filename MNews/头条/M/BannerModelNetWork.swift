//
//  BannerModelNetWork.swift
//  MNews
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


extension BannerModel{

    // MARK:- 请求滚动条数据
    class func requestBannerData(callBack:(array:[AnyObject]?,error:NSError?) -> Void) -> Void{
       /*
         滚动条:
         
         http://reader.meizu.com/android/unAuth/index/getBanner.do?supportSDK=16&deviceType=MX4&v=2820&operator=46007&nt=wifi&vn=2.8.20&deviceinfo=kT4rm8nWF%2B7cLc6jl0QuVSGmZxE0O3h%2F0TiKXj3sildRKH3znV4OeFTEkmEtrSLS%2Bcj0vlH7oKeyoA9dkvshildsiVb%2Bq1lmey6MKENCruJcfJBsBkwmGTE3eG85ShykdEzkssL2rx5ixtuprXk13lcDhziAkOr5tS3tToe%2Bl8o%3D&os=5.1-1469416338_stable
         */
        
        let url = "http://reader.meizu.com/android/unAuth/index/getBanner.do?supportSDK=16&deviceType=MX4&v=2820&operator=46007&nt=wifi&vn=2.8.20&deviceinfo=kT4rm8nWF%2B7cLc6jl0QuVSGmZxE0O3h%2F0TiKXj3sildRKH3znV4OeFTEkmEtrSLS%2Bcj0vlH7oKeyoA9dkvshildsiVb%2Bq1lmey6MKENCruJcfJBsBkwmGTE3eG85ShykdEzkssL2rx5ixtuprXk13lcDhziAkOr5tS3tToe%2Bl8o%3D&os=5.1-1469416338_stable"
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
            if error == nil{
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                
//                let str = try! NSString.init(data: data!, encoding: NSUTF8StringEncoding)
//                print(str!)
                
                let array = (obj["value"] as? [AnyObject])![0]["data"] as? [AnyObject]
                var models:NSMutableArray? = nil
                do{
                    models = try BannerModel.arrayOfModelsFromDictionaries(array,error:())
                    
                }catch{
                    models = NSMutableArray()
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: models! as [AnyObject],error:  nil)
                })
                
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), { 
                    callBack(array: nil,error: error)
                })
            
            }
        }
        
        
    }
    
}

extension ContentModel{
    // MARK: - 请求展示内容数组
    class func requestData(callBack:(array:[AnyObject]?,error:NSError?) -> Void) -> Void {
    
        let url = "http://reader.meizu.com/android/unauth/index/latest_articles.do?articleId=122614556&supportSDK=16&putdate=1474439444000&columnIds=34_1_2_19_20_16_4_37_5_14_9_18_10_7_3&deviceType=MX4&v=2820&operator=46007&nt=wifi&vn=2.8.20&deviceinfo=VpE0Ek7u0%2B%2BdlqU%2FcanUjJ27f1Y4WsSeqm2UCIaGYVU0Pm%2BQ0EwXd4AA%2B%2BJqHfOYqEDbY556tFNcvAw2x7fg5ceJz2LUAHlGzN1l1iDvOZ6SwBIPS72t46y2BiG9Y81X4jRLrhwunhrL3fnkWEuUYkUv%2FxkYfAqSjMC1S0Wcd0c%3D&os=5.1-1469416338_stable"
        BaseRequest.getWithURL(url, para: nil) { (data, error) in
            if error == nil{
//                let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding)
//                print(str!)
                
                
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                let array = obj["value"]!["articles"] as? [AnyObject]
                var models:NSMutableArray? = nil
                
                do{
                    models = try ContentModel.arrayOfModelsFromDictionaries(array, error: ())
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



























