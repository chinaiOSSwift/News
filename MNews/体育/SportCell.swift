//
//  SportCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SportCell: UICollectionViewCell {
    
    
    // 代理指针
    weak var delegate:ShowDetail?
    //数据源
    var dataArr = NSMutableArray()
    var page:NSInteger = 1
    var flag:Bool = false
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, Scr_W, Content_H + btnH))
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerNib(UINib.init(nibName: "SciCell", bundle: nil), forCellReuseIdentifier: "SciCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.page = 1
            self.flag = true
            self.loadData()
        })
        tableView.footer = MJRefreshAutoFooter.init(refreshingBlock: {
            self.page += 1
            self.flag = false
            self.loadData()
        })
        tableView.backgroundColor = ContentColor
        self.contentView.addSubview(tableView)
        return tableView
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 网络加载
    func loadData() -> Void {
        let url = "http://apis.baidu.com/txapi/tiyu/tiyu"
        //        let httpArg = "num=10&page=1"
        let httpArg = String.init(format: "%@%d", "num=10&page=",self.page)
        HDManager.startLoading()
        SportModel.requestDtat(HOME_URL: url, httpArg: httpArg) { (array, error) in
            if error == nil{
                if self.flag == true{
                    self.dataArr.removeAllObjects()
                }
                self.dataArr.addObjectsFromArray(array!)
                self.tableView.reloadData()
                print("单独的请求    体育数据:\(self.dataArr.count)")
                self.tableView.header.endRefreshing()
                self.tableView.footer.endRefreshing()
            }
            HDManager.stopLoading()
        }
    }
}

//MARK: - UITableView 协议方法
extension SportCell: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SciCell", forIndexPath: indexPath) as! SciCell
        let model = self.dataArr[indexPath.row] as! SportModel
        cell.titleL.text = model.title
        cell.iconView.sd_setImageWithURL(NSURL.init(string: model.picUrl))
        cell.contentSourceL.text = model.Description
        cell.contentCountL.text = model.ctime
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // 当点击的时候下载相对应的 json 文件
        let model = self.dataArr[indexPath.row] as! SportModel
        let web = DetailViewController()
        web.url = model.url
        self.delegate?.showDetailView(web)
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Content_H / 6
    }
    
}




