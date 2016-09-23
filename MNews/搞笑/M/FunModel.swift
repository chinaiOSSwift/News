//
//  FunModel.swift
//  MNews
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


class FunModel:JSONModel{
    var articleId:NSNumber! // 文章ID
    var articleUrl:String! // 文章的JSON
    var contentSourceName:String! // 网易头条
    var commentCount:NSNumber! // 回复条数
    var Description:String! // 文章的描述
    var imgUrlList:NSArray? // 存放图片数组
    var pv:NSNumber! // 看过的人数
    var title:String! // 文章的标题
}



