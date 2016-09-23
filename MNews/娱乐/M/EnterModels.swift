//
//  EnterModels.swift
//  MNews
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
class EnterModel:JSONModel{
    //    var cid:NSNumber!
    var cmtUrl:String! // 评论url
    var id:String! // 文章的id
    var sourceName:String! // 凤凰娱乐
    var title:String! // 标题
    var url:String! // 网站url
    var zzdUrl:String! // 另一网站url
    var originalUrl:String! // 原生网址
    var imageUrl:String!
    // aa_bb -> aaBb
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
    //
    override class func propertyIsOptional(propertyName:String) -> Bool {
        return true
    }
}