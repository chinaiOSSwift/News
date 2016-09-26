//
//  DataManager.swift
//  a25WanYanYong
//
//  Created by qianfeng on 16/9/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    // 只构建一次,想当于单例
    
    static let manager = DataManager()
    
    let fmdb:FMDatabase
    
    override init() {
        // 需要管理的数据库路径
        let path = NSHomeDirectory() + "/Documents/favo.db"
        // 数据库路径 和 FMDB 建立关系
        fmdb = FMDatabase.init(path: path)
        // 打开数据库 如果文件存在就打开, 不存在先创建再打开
        
        if !fmdb.open(){
            print(fmdb.lastErrorMessage())
            return
        }
        
        /*
         var ID:String?
         var thumb:String?
         var title:String?
         */
        let createSql = "create table if not exists favo(numID integer primary key autoincrement, link varchar(255), pubDate varchar(255), source varchar(255), title varchar(255))"
        
        do{
            // 执行sql 语句
            try fmdb.executeUpdate(createSql, values: nil)
        }catch{
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
    }
    // MARK: - 插入一条数据
    func insert(model:BaseModel) -> Void {
        fmdb.open()
        let insertSql = "insert into favo(link,pubDate,source,title) values(?,?,?,?)"
        do{
            try fmdb.executeUpdate(insertSql, values: [model.link,model.pubDate,model.source,model.title])
        }catch{
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
    }
    // MARK: - 查询所有的数据
    func findAll() -> [BaseModel] {
        fmdb.open()
        var tempArr = [BaseModel]()
        let findAll = "select * from favo"
        do {
            let rs = try fmdb.executeQuery(findAll, values: nil)
            while rs.next() {
                let model = BaseModel()
                model.link = rs.stringForColumn("link")
                model.pubDate = rs.stringForColumn("pubDate")
                model.source = rs.stringForColumn("source")
                model.title = rs.stringForColumn("title")
                tempArr.append(model)
            }
        }catch{
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
        return tempArr
    }
    // MARK: - 删除一条数据
    func deleteOne(title:String) -> Void {
        fmdb.open()
        let deleteSql = "delete from favo where title = ?"
        do {
            try fmdb.executeUpdate(deleteSql, values: [title])
        } catch{
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
    }
    
    //MARK: -  查找一个数据
    func findOne(title:String) -> Bool {
        fmdb.open()
        var flag = false
        let findOne = "select * from favo where title = ?"
        do {
            let rs = try fmdb.executeQuery(findOne, values: [title])
            while rs.next() {
                flag = true
            }
        }catch{
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
        return flag
    }
    
    func deleteAll() -> Void {
        fmdb.open()
        let deleteAll = "drop table favo"
        do {
            try fmdb.executeUpdate(deleteAll, values: nil)
        }catch{
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
    }
    
    
}
























