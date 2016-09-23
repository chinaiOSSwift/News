//
//  BaseRequest.swift
//  PoKitchen
//
//  Created by 夏婷 on 16/7/25.
//  Copyright © 2016年 夏婷. All rights reserved.
//

import UIKit



// MARK: - 公用的数据模型
class ContentModel:JSONModel{
    var articleId:NSNumber!
    var articleUrl:String!
    var contentSourceName:String!  // 网易头条
    var Description:String! // 描述
    var commentCount:NSNumber! // 浏览次数
    var imgUrlList:NSArray! // 图片数组
    var pv:NSNumber!
    var title:String!
    
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.init(modelToJSONDictionary: ["Description":"description"])
        // 特殊处理某一个字段,模型中的属性 和字典中的key  不一致时, 设置赋值对应关系,模型中的属性名作为键,字典中的key 作为value
        
    }
    
    override class func propertyIsOptional(propertyName:String) -> Bool{
        return true
    }
    
}


class BaseRequest{
    
    class func getWithURL(url:String!,para:NSDictionary?,callBack:(data:NSData?,error:NSError?)->Void)->Void
    {
        let session = NSURLSession.sharedSession()
        
        let urlStr = NSMutableString.init(string: url)
        if para != nil {
            urlStr.appendString(self.encodeUniCode(self.parasToString(para!)) as String)
            print("get - urlStr = \(urlStr)")

            
        }
        let request = NSMutableURLRequest.init(URL: (NSURL.init(string: urlStr as String))!)
        request.HTTPMethod = "GET"
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
//            let res:NSHTTPURLResponse = response as! NSHTTPURLResponse
            if data != nil
            {
                callBack(data:data,error:nil)
            }else
            {
                callBack(data:nil,error:error)
            }
        }
        //启动请求任务
        dataTask .resume()
    }
    
    class func postWithURL(url:String!,para:NSDictionary?,callBack:(data:NSData?,error:NSError?)->Void)->Void{
        let session = NSURLSession.sharedSession()
        
        let urlStr = NSMutableString.init(string: url)
        if para != nil {
            urlStr.appendString(self.encodeUniCode(self.parasToString(para!)) as String)
        }
        print("post = \(urlStr)")
        let request = NSMutableURLRequest.init(URL: (NSURL.init(string: urlStr as String))!)
        request.HTTPMethod = "POST"
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            
            if error == nil
            {
                callBack(data:data,error:nil)
            }else
            {
                callBack(data:nil,error:error)
            }
        }
        //启动请求任务
        dataTask .resume()
    }
    
    class func parasToString(para:NSDictionary?)->String
    {
        let paraStr = NSMutableString.init(string: "?")
        for (key,value) in para as! [String :String]
        {
            paraStr.appendFormat("%@=%@&", key,value)
        }
        if paraStr.hasSuffix("&"){
            paraStr.deleteCharactersInRange(NSMakeRange(paraStr.length - 1, 1))
        }
        //将URL中的特殊字符进行转吗
//        paraStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        //移除转码
//        paraStr.stringByRemovingPercentEncoding
        return String(paraStr)
    }
    
    class func encodeUniCode(string:NSString)->NSString
    {
        return string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
    }

    
}
// MARK: - 通过的网络请求
extension ContentModel{
    // MARK: - 请求展示内容数组
    class func requestData(url:String,callBack:(array:[AnyObject]?,error:NSError?) -> Void) -> Void {
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

















