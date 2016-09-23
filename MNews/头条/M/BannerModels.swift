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





































