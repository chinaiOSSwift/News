//
//  BannerModels.swift
//  MNews
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

class BannerModel:JSONModel{
    
    var articleId:NSNumber!
    var articleUrl:String!
    var title:String!
    var imgUrlList:NSArray!
    var vScreenImg:String!
    var vTitle:String!
    override class func propertyIsOptional(propertyName:String) -> Bool{
        return true
    }
}


class ContentModel:JSONModel{
    var articleId:NSNumber!
    var articleUrl:String!
    var contentSourceName:String!  // 网易头条
    var Description:String! // 描述
    var commentCount:NSNumber! // 浏览次数
    var imgUrlList:NSArray! // 图片数组
    var title:String!
    
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.init(modelToJSONDictionary: ["Description":"description"])
        // 特殊处理某一个字段,模型中的属性 和字典中的key  不一致时, 设置赋值对应关系,模型中的属性名作为键,字典中的key 作为value
        
    }
    
    override class func propertyIsOptional(propertyName:String) -> Bool{
        return true
    }
    
}


































