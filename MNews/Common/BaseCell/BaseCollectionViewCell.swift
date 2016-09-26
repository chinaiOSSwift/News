//
//  BaseCollectionViewCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit



class BaseCollectionViewCell: UICollectionViewCell {
    
    
    
    // 代理指针
    weak var delegate:ShowDetail?
    //数据源
    var dataArr = NSMutableArray()
    var page:NSInteger = 1
    var flag:Bool = false
    var channelID:String!
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
        if let array = self.readLocalData(){
            self.dataArr = NSMutableArray.init(array: array)
//            print("第一次加载数据得到的结果 : \(self.dataArr.count)")
            self.tableView.reloadData()
        }else{
            self.loadData()
        }
    }
    
    //MARK: - 网络加载
    func loadData() -> Void{
        let preArg = "channelId=\(self.channelID)&page="
        let behArg = "&needContent=0&needHtml=0"
        let httpArg = String.init(format: "%@%d%@", preArg,self.page,behArg)
        HDManager.startLoading()
        BaseModel.requestBaseDtat(HOME_URL: HOME_URL, httpArg: httpArg) { (array, error) in
            if error == nil{
                if self.flag == true{
                    self.dataArr.removeAllObjects()
                    self.writeToDataWith(array!)
                }
                self.dataArr.addObjectsFromArray(array!)
                self.tableView.reloadData()
               
            }else{
                self.setNetWorkView()
            }
            self.tableView.header.endRefreshing()
            self.tableView.footer.endRefreshing()
            HDManager.stopLoading()
        }
    }
    
    // MARK: - 无网络界面
    func setNetWorkView() -> Void {
        
        print("121212")
        let url = NSURL.init(string: "prefs:root=Brightness")
        if UIApplication.sharedApplication().canOpenURL(url!) {
            UIApplication.sharedApplication().openURL(url!)
            print("调用系统的设置按钮")
        }
        let ac = UIAlertController.init(title: "⚠️", message: "无网络连接, 请检查网络设置", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default) { (action) in
            
            let url = NSURL.init(string: "prefs:root=General")
            if UIApplication.sharedApplication().canOpenURL(url!) {
                UIApplication.sharedApplication().openURL(url!)
                print("调用系统的设置按钮")
            }
            
        }
        ac.addAction(action)
        self.delegate?.sentMessage(ac)
        
        
        
        
        
        
        /*
        let netView = UIView.init(frame:CGRectMake(0, 0, Scr_W , Scr_H - btnH))
        netView.center = self.contentView.center
        //        netView.backgroundColor = UIColor.redColor()
        let imageView = UIImageView.init(frame: CGRectMake(0, 0, 50, 50))
        imageView.mj_x = netView.center.x - 25
        imageView.mj_y = netView.center.y - 100
        imageView.image = UIImage.init(named: "netWork.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        //        imageView.backgroundColor = UIColor.greenColor()
        let tipL = UILabel.init(frame: CGRectMake(0, 0, 300, 23))
        tipL.mj_x = imageView.center.x - 150
        tipL.mj_y = imageView.mj_y + imageView.mj_h + 5
        //        tipL.backgroundColor = UIColor.brownColor()
        tipL.font = UIFont.systemFontOfSize(17)
        tipL.text =  "无网络连接, 请检查网络设置"
        tipL.textAlignment = NSTextAlignment.Center
        tipL.textColor = NavColor
        netView.addSubview(tipL)
        netView.addSubview(imageView)
        self.contentView.addSubview(netView)
        // 添加点击手势
        netView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.setNetWork))
        netView.addGestureRecognizer(tap)
        */
        
    }
    
    
    // MARK: - 设置网络连接
    func setNetWork() -> Void {
        self.loadData()
        //        print("应该跳转到网络设置")
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableView 协议方法
extension BaseCollectionViewCell: UITableViewDelegate, UITableViewDataSource{
    
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
        web.titleName = model.source
        web.url = model.link
        web.model = model
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

extension BaseCollectionViewCell{
    // 往本地存储数据
    func writeToDataWith(array:NSArray) -> Void {
        print("写入的个数:\(array.count)")
        let name = NSStringFromClass(self.dynamicType) // self Type dynamicType 三个关键字
        // 拼接完整的沙盒路径
        let path = String.init(format: "%@/Documents/%@.txt", NSHomeDirectory(),name)
        print("写入path = \(path)")
        //
        let flag = NSKeyedArchiver.archiveRootObject(array, toFile: path)
        if flag {
            print("归档成功")
        }
    }
    // 读本地文件
    func readLocalData() -> NSArray? {
        let name = NSStringFromClass(self.dynamicType)
        let path = String.init(format: "%@/Documents/%@.txt", NSHomeDirectory(),name)
        let array = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? NSArray
        return array
    }
    
}


































