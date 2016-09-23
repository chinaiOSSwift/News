//
//  SocialCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SocialCell: UICollectionViewCell {
    
    // 代理指针
    weak var delegate:ShowDetail?
    // 数据源
    var dataArr = [EnterModel]()
    var idArr = ["12200222036227242786"]
    var page:NSInteger = 0
    var flag:Bool = false
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, Scr_W, Content_H + btnH))
        tableView.backgroundColor = UIColor.brownColor()
        tableView.registerNib(UINib.init(nibName: "SciCell", bundle: nil), forCellReuseIdentifier: "SciCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
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
        tableView.backgroundColor = ContentColor
        
        self.contentView.addSubview(tableView)
        return tableView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.loadData(self.page)
        
    }
    
    //MARK: - 网络数据加载
    func loadData(page:NSInteger) -> Void {
        let preUrl = "https://m.uczzd.cn/iflow/api/v1/channel/1192652582?recoid="
        let behUrl = "&method=new&app=meizunews-iflow&auto=0&uc_param_str=frvesvmibichntgsdd&count=20&no_op=0&ftime=1474626136836&content_ratio=0&fr=android&ve=1.1.0&sv=official&mi=MX4&bi=35019&ch=meizu_news_sdk&nt=2&gs=lat:14413466;lon:41893203&dd=VktqTmZzNXFqNjBEQU5JMFI3SGExTVdo"
        
//        https://m.uczzd.cn/iflow/api/v1/channel/1192652582?recoid=12200222036227242786&method=new&app=meizunews-iflow&auto=0&uc_param_str=frvesvmibichntgsdd&count=20&no_op=0&ftime=1474626136836&content_ratio=0&fr=android&ve=1.1.0&sv=official&mi=MX4&bi=35019&ch=meizu_news_sdk&nt=2&gs=lat:14413466;lon:41893203&dd=VktqTmZzNXFqNjBEQU5JMFI3SGExTVdo
        
        
        let url = String.init(format: "%@%@%@", preUrl,self.idArr[self.page],behUrl)
        HDManager.startLoading()
        EnterModel.requestData(url) { (array,ids, error) in
            if error == nil{
                if self.flag == true{
                    self.dataArr.removeAll()
                }
                for model in (array as! [EnterModel]){
                    self.dataArr.append(model)
                }
                
            }
            for id in ids! {
                self.idArr.append(id)
            }
            print("社会数据: = \(self.dataArr.count), id = \(self.idArr.count)")
            self.tableView.reloadData()
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
extension SocialCell: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SciCell", forIndexPath: indexPath) as! SciCell
        let model = self.dataArr[indexPath.row]
        //        print("刚才出错: \(model.imageUrl)")
        if model.imageUrl != nil{
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
        print("娱乐 = \(model.zzdUrl)")
        self.delegate?.showDetailView(web)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Content_H / 6
    }
    
    
}
