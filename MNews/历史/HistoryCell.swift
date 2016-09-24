//
//  HistoryCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    
    // 代理指针
    weak var delegate:ShowDetail?
    //数据源
    var dataArr = NSMutableArray()
    var page:NSInteger = 1
    var flag:Bool = false
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, Scr_W, Content_H + btnH))
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.registerNib(UINib.init(nibName: "BaseZeroCell", bundle: nil), forCellReuseIdentifier: "BaseZeroCell")
        tableView.registerNib(UINib.init(nibName: "BaseModelOneCell", bundle: nil), forCellReuseIdentifier: "BaseModelOneCell")
        tableView.registerNib(UINib.init(nibName: "BaseModelTwoCell", bundle: nil), forCellReuseIdentifier: "BaseModelTwoCell")
        tableView.registerNib(UINib.init(nibName: "BaseModelThreeCell", bundle: nil), forCellReuseIdentifier: "BaseModelThreeCell")
        
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
    
    //MARK: - 网络加载
    func loadData() -> Void{
        let preArg = "channelId=5572a109b3cdc86cf39001e4&page="
        let behArg = "&needContent=0&needHtml=0"
        let httpArg = String.init(format: "%@%d%@", preArg,self.page,behArg)
        HDManager.startLoading()
        BaseModel.requestBaseDtat(HOME_URL: HOME_URL, httpArg: httpArg) { (array, error) in
            if error == nil{
                if self.flag == true{
                    self.dataArr.removeAllObjects()
                }
                self.dataArr.addObjectsFromArray(array!)
                print("房产最新 :\(self.dataArr.count)")
                self.tableView.reloadData()
                self.tableView.header.endRefreshing()
                self.tableView.footer.endRefreshing()
            }
            HDManager.stopLoading()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableView 协议方法
extension HistoryCell: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model = self.dataArr[indexPath.row] as! BaseModel
        var cellID = "BaseZeroCell"
        
        if model.imageurls?.count == 1{ // 一张图片
            cellID = "BaseModelOneCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! BaseModelOneCell
            cell.customCellWithModel(model)
            return cell
        }else if model.imageurls?.count == 2{ // 两张图片
            cellID = "BaseModelTwoCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! BaseModelTwoCell
            cell.customCellWithModel(model)
            return cell
        }else if model.imageurls?.count == 3{ // 三张图片
            cellID = "BaseModelThreeCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! BaseModelThreeCell
            cell.customCellWithModel(model)
            return cell
        }else{
            // 没有图片
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! BaseZeroCell
            cell.customCellWithDic(model)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // 当点击的时候下载相对应的 json 文件
        let model = self.dataArr[indexPath.row] as! BaseModel
        let web = DetailViewController()
        web.url = model.link
        self.delegate?.showDetailView(web)
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let model = self.dataArr[indexPath.row] as! BaseModel
        if model.imageurls?.count == 3 || model.imageurls?.count == 2{
            return 180
        }
        return Content_H / 6
    }
    
}
