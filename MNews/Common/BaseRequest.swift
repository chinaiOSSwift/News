//
//  BaseRequest.swift
//  PoKitchen
//
//  Created by 夏婷 on 16/7/25.
//  Copyright © 2016年 夏婷. All rights reserved.
//

import UIKit

// MARK: - 基础模型
class BaseModel:NSObject, NSCoding{
    var imageurls:[[String:AnyObject]]?
    var link:String!
    var pubDate:String!
    var source:String!
    var title:String!
    
    override init() {
        super.init()
    }
    
    class func modelWithDic(dic:[String:AnyObject]) -> BaseModel{
        let model = BaseModel()
        model.imageurls = dic["imageurls"] as? [[String:AnyObject]]
        model.link = dic["link"] as! String
        model.pubDate = dic["pubDate"] as! String
        model.source = dic["source"] as! String
        model.title = dic["title"] as! String
        return model
    }
    //MARK: - 归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(imageurls, forKey: "imageurls")
        aCoder.encodeObject(link, forKey: "link")
        aCoder.encodeObject(pubDate, forKey: "pubDate")
        aCoder.encodeObject(source, forKey: "source")
        aCoder.encodeObject(title, forKey: "title")
    }
    // MARK: - 解档
    required init?(coder aDecoder: NSCoder) {
        self.imageurls = aDecoder.decodeObjectForKey("imageurls") as? [[String:AnyObject]]
        self.link = aDecoder.decodeObjectForKey("link") as? String
        self.pubDate = aDecoder.decodeObjectForKey("pubDate") as? String
        self.source = aDecoder.decodeObjectForKey("source") as? String
        self.title = aDecoder.decodeObjectForKey("title") as? String
    }
    
    
}

// MARK: - 针对基础模型的网络请求
extension BaseModel{
    
    class func  requestBaseDtat(HOME_URL httpUrl: String, httpArg: String,callBack:(array:[AnyObject]?,error:NSError?) -> Void)->Void {
        let req = NSMutableURLRequest(URL: NSURL(string: httpUrl + "?" + httpArg)!)
        req.timeoutInterval = 6
        req.HTTPMethod = "GET"
        req.addValue(apikey, forHTTPHeaderField: "apikey")
        //        print("请求的网址: \(req)")
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) -> Void in
            if error == nil{
                //let str = NSString.init(data: data!, encoding: NSUTF8StringEncoding)
                //print(str!)
                
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let array = ((obj["showapi_res_body"] as! NSDictionary)["pagebean"] as! NSDictionary)["contentlist"] as? [AnyObject]
                let models:NSMutableArray = NSMutableArray()
                if array?.count > 0{
                    for dic in (array as! [[String:AnyObject]]){
                        models.addObject(BaseModel.modelWithDic(dic))
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: models as [AnyObject], error: nil)
                })
            }else{
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(array: nil, error: error)
                })
            }
        }
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






















