//
//  RecCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class RecCell: UICollectionViewCell {
    
    
    // 代理指针
    weak var delegate:ShowDetail?
    // 数据源
    var dataArr = [RecModel]()
    
    
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, Scr_W, Content_H))
        tableView.backgroundColor = UIColor.brownColor()
        tableView.registerNib(UINib.init(nibName: "SciCell", bundle: nil), forCellReuseIdentifier: "SciCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.backgroundColor = ContentColor
        self.contentView.addSubview(tableView)
        return tableView
        
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.whiteColor()
        // 
        self.loadData()
        
        
    }
    //MARK: - 网络加载
    func loadData() -> Void {
        let url = "https://m.uczzd.cn/iflow/api/v1/channel/100?recoid=14086016498208926587&method=new&app=meizunews-iflow&auto=0&uc_param_str=frvesvmibichntgsdd&count=20&no_op=0&ftime=1474557338960&content_ratio=0&fr=android&ve=1.1.0&sv=official&mi=MX4&bi=35019&ch=meizu_news_sdk&nt=2&gs=lat:14413464;lon:41893202&dd=VktqTmZzNXFqNjBEQU5JMFI3SGExTVdo"
        HDManager.startLoading()
        RecModel.requestData(url) { (array, error) in
            if error == nil {
                self.dataArr = array as! [RecModel]
                self.tableView.reloadData()
                print("推荐数据: = \(self.dataArr.count)")
            }
            HDManager.stopLoading()
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UITableView 协议方法
extension RecCell: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SciCell", forIndexPath: indexPath) as! SciCell
        let model = self.dataArr[indexPath.row]
        
        cell.iconView?.sd_setImageWithURL(NSURL.init(string: model.imageUrl))
        
        cell.titleL.text = model.title
        cell.contentCountL.text = ""
        cell.contentSourceL.text = ""
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // 当点击的时候下载相对应的 json 文件
        let model = self.dataArr[indexPath.row]
        let web = DetailViewController()
        web.url = model.originalUrl
        self.delegate?.showDetailView(web)
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Content_H / 6
    }
    
}









