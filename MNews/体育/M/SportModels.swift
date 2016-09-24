//
//  SportModels.swift
//  MNews
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


class SportModel:JSONModel{

    /*
     "ctime": "2016-04-08 20:00",  //新闻发布时间
     "title": "大马赛-王仪涵横扫马林进4强 田卿赵云蕾止步8强", //新闻标题
     "description": "凤凰体育",  //新闻来源
     "picUrl": "http://d.ifengimg.com/w145_h103/y3.ifengimg.com/cmpp/2016/04/08/72030b9663bb84fad799b3f8338b025d_size317_w500_h350.jpg",  //新闻图片
     "url": "http://sports.ifeng.com/a/20160408/48396914_0.shtml"  //新闻链接
     
     */
    
    var ctime:String!
    var title:String!
    var Description:String!
    var picUrl:String!
    var url:String!
    
    override class func keyMapper() -> JSONKeyMapper{
        return JSONKeyMapper.init(modelToJSONDictionary: ["Description":"description"])
    
    }
    
    override class func propertyIsOptional(propertyName:String) -> Bool{
        return true
    
    }
}













