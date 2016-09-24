//
//  ScienceCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
//5572a10ab3cdc86cf39001f4
class ScienceCell: UICollectionViewCell {
    
    // 代理指针
    weak var delegate:ShowDetail?
    //数据源
    var dataArr = NSMutableArray()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, Scr_W, Content_H))
        tableView.backgroundColor = UIColor.whiteColor()
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
        
        self.dataLoad()
    }
    // MARK: - 网络请求
    func dataLoad() -> Void {
        
    
        let date = NSDate.init(timeIntervalSince1970: 1474546734000)
        let formate = NSDateFormatter.init()
        formate.dateFormat = "YYYY-MM-dd HH:mm:ss"
        print(date)
        let interval = NSTimeIntervalSince1970
        print(interval)
        
    
//        let url = "http://reader.meizu.com/android/unauth/columns/article/refresh.do?lastTime=1474546734000&articleId=122727898&columnId=2&v=2820&operator=46007&nt=wifi&vn=2.8.20&deviceinfo=wmwPl%2B1aYe0hhHiQsGeqU603kp6E2PesAc7Rt6p34d57Blxcma25kZTyFu7VjL88G2yVvAKuy177NdJ5d%2FAL2X%2Bvf2OKDL8PH%2B7xOH%2FHALhnf4jOd40m9giVbv4nchM2jFxiU6AV726Xn8nteKdOjyJmkIFJqYeGzlvCbP0ehX8%3D&os=5.1-1469416338_stable"
        let url = "http://reader.meizu.com/android/unauth/columns/article/list.do?columnId=2&v=2820&operator=46007&nt=wifi&vn=2.8.20&deviceinfo=WKEkCva5gyfS5gI67r6trHzh924ZeVQlpXJ2s6sAGq4QZyKfeYQw%2BeA%2FItDLshKe%2FHN5lfQmn4qR94II2GtNqn77%2F%2BS5en1unDDorJvI%2B5tz4LZoH5ICxuuDsfm1Ih87%2FBgU7HuKroipF1U1DBibVvnbo68lRff2%2B2I9FNPHTGc%3D&os=5.1-1469416338_stable"
        HDManager.startLoading()
        ContentModel.requestData(url) { (array, error) in
            if error == nil {
                self.dataArr.addObjectsFromArray(array!)
                print("科技页面数据: = \(self.dataArr.count)")
                self.tableView.reloadData()
            }
            HDManager.stopLoading()
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableView 协议方法
extension ScienceCell: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SciCell", forIndexPath: indexPath) as! SciCell
        let model = self.dataArr[indexPath.row] as! ContentModel
        print("科技 = \(model.imgUrlList.count) \(String(model.imgUrlList.firstObject))")
        if model.imgUrlList.firstObject != nil || model.imgUrlList.count != 0{
            cell.iconView?.sd_setImageWithURL(NSURL.init(string:  String(model.imgUrlList.firstObject!)))
            
        }
        cell.titleL.text = model.title
        cell.contentCountL.text = "\(model.pv)" + "人看过"
        cell.contentSourceL.text = model.contentSourceName
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // 当点击的时候下载相对应的 json 文件
        let model = self.dataArr[indexPath.row] as! ContentModel
        let web = DetailViewController()
        web.url = PaseFile.paseFile(model.articleUrl)
        self.delegate?.showDetailView(web)
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Content_H / 6
    }
    
}










