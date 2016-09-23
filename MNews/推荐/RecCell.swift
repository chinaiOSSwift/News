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
    var idArr = ["15587340890137789538"]
//    15587340890137789538  14086016498208926587
    var page:NSInteger = 0
    var flag:Bool = false
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, Scr_W, Content_H + btnH))
        tableView.backgroundColor = UIColor.brownColor()
        tableView.registerNib(UINib.init(nibName: "SciCell", bundle: nil), forCellReuseIdentifier: "SciCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.redColor()
        tableView.header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.page = 1
            self.flag = true
            self.loadData(self.page)
        })
        tableView.footer = MJRefreshAutoFooter.init(refreshingBlock: {
            self.page += 1
            self.flag = false
            self.loadData(self.page)
        })
        tableView.bounces = true
        tableView.backgroundColor = ContentColor
        self.contentView.addSubview(tableView)
        return tableView
        
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.loadData(self.page)
    }
    //MARK: - 网络加载
    func loadData(page:NSInteger) -> Void {
        
        let preUrl = "https://m.uczzd.cn/iflow/api/v1/channel/100?recoid="
        let behUrl = "&method=new&app=meizunews-iflow&auto=0&uc_param_str=frvesvmibichntgsdd&count=20&no_op=0&ftime=1474557338960&content_ratio=0&fr=android&ve=1.1.0&sv=official&mi=MX4&bi=35019&ch=meizu_news_sdk&nt=2&gs=lat:14413464;lon:41893202&dd=VktqTmZzNXFqNjBEQU5JMFI3SGExTVdo"
        let url = String.init(format: "%@%@%@", preUrl,self.idArr[self.page],behUrl)
        HDManager.startLoading()
        RecModel.requestFootData(url) { (array,ids, error) in
            if self.flag == true{
                self.dataArr.removeAll()
            }
            if error == nil{
                for model in (array as! [RecModel]) {
                    self.dataArr.append(model)
                }
                for id in ids! {
                    self.idArr.append(id)
                }
                self.tableView.reloadData()
                print("触底加载数据:\(self.dataArr.count)")
            }
            HDManager.stopLoading()
            self.tableView.header.endRefreshing()
            self.tableView.footer.endRefreshing()
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
        //        print("推荐出错: \(model.imageUrl)")
        if model.imageUrl == nil || model.imageUrl == ""{
            
        }else{
            cell.iconView?.sd_setImageWithURL(NSURL.init(string: model.imageUrl))
        }
        cell.titleL.text = model.title
        cell.contentCountL.text = ""
        cell.contentSourceL.text = model.sourceName
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // 当点击的时候下载相对应的 json 文件
        let model = self.dataArr[indexPath.row]
        let web = DetailViewController()
        web.url = model.zzdUrl
        self.delegate?.showDetailView(web)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Content_H  / 6
    }
    
}









