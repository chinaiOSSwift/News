//
//  TitleModel.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation


class TitleModel:JSONModel{
    var id:String!
    var name:String!
    
    
    //当字典中的key 的个数和 模型属性的个数不完全匹配时，需要实现下面这个方法，并且返回 true ，这样才能保证 将字典中的值赋给相应的属性
    override class func propertyIsOptional(propertyName:String)->Bool{
        return true
    }
    
    
    
    
}













