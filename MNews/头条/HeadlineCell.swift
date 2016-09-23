//
//  HeadlineCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol ShowDetail:NSObjectProtocol {
    func showDetailView(web:DetailViewController) -> Void
}

class HeadlineCell: UICollectionViewCell {
    
    weak var delegate:ShowDetail?
    var pageCont = UIPageControl()
    var bannerArray = NSMutableArray()
    var contentArr = NSMutableArray()
    lazy var headView:UIView = {
        let view = UIView.init(frame: CGRectMake(0, 0, Scr_W,SrcollView_H))
        print("赋值前:\(self.bannerArray.count) ")
        let scrollView = MyScrollView.init(frame: CGRectMake(0, 0, view.mj_w,view.mj_h), arr: self.bannerArray, isTimer: true)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegator = self
        let pageRect = CGRectMake(view.mj_w - 80, view.mj_h - 20, 80, 20)
        self.pageCont.frame = pageRect
        //                pageCont.backgroundColor = UIColor.whiteColor()
        self.pageCont.numberOfPages = self.bannerArray.count
        self.pageCont.currentPage = scrollView.currentPage!
        self.pageCont.userInteractionEnabled = false
        // 小圆点的颜色
        self.pageCont.currentPageIndicatorTintColor = NavColor
        self.pageCont.pageIndicatorTintColor = UIColor.grayColor()
        view.addSubview(scrollView)
        view.addSubview(self.pageCont)
        view.bringSubviewToFront(self.pageCont)
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, Scr_W, Content_H))
        tableView.backgroundColor = UIColor.brownColor()
        tableView.tableHeaderView = self.headView
        tableView.registerNib(UINib.init(nibName: "HeadCell", bundle: nil), forCellReuseIdentifier: "HeadCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        self.contentView.addSubview(tableView)
        return tableView
        
    }()
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.loadData()
    }
    // MARK: - 网络加载数据
    func loadData() -> Void {
        //        let url = "http://reader.meizu.com/android/unauth/index/latest_articles.do?articleId=122614556&supportSDK=16&putdate=1474439444000&columnIds=34_1_2_19_20_16_4_37_5_14_9_18_10_7_3&deviceType=MX4&v=2820&operator=46007&nt=wifi&vn=2.8.20&deviceinfo=VpE0Ek7u0%2B%2BdlqU%2FcanUjJ27f1Y4WsSeqm2UCIaGYVU0Pm%2BQ0EwXd4AA%2B%2BJqHfOYqEDbY556tFNcvAw2x7fg5ceJz2LUAHlGzN1l1iDvOZ6SwBIPS72t46y2BiG9Y81X4jRLrhwunhrL3fnkWEuUYkUv%2FxkYfAqSjMC1S0Wcd0c%3D&os=5.1-1469416338_stable"
        
        let url = "http://reader.meizu.com/android/unauth/index/latest_articles.do?articleId=122708732&supportSDK=16&putdate=1474588053000&columnIds=34_1_2_19_20_16_4_37_5_14_9_18_10_7_3_25_23_15_40_41_17_24_26_29_28_30_31_32_21_6&deviceType=MX4&v=2820&operator=46007&nt=wifi&vn=2.8.20&deviceinfo=TD0FxRLgnTr%2FKSlvzaoH%2B0IWG0uV53nTTGKHI68jUHezpZyAXOHYUyswalmpjtGYug1RGYtF4K6OELXz7U5ucKlZfH9PHvV%2BYNrlMOn%2BS5nmOOq4N%2B3mEem%2Bz7HLUN7xiYxfcA7Ea2KxY4lkphp3z%2Fi%2FddTMaH61v9j61JHVqso%3D&os=5.1-1469416338_stable"
        
        HDManager.startLoading()
        print("出错前前")
        BannerModel.requestBannerData { (array, error) in
            if error == nil{
                print("出错前")
                self.bannerArray.addObjectsFromArray(array!)
                print("滚动条数据:= \(self.bannerArray.count)")
            }
            HDManager.stopLoading()
        }
        HDManager.startLoading()
        ContentModel.requestData(url) { (array, error) in
            if error == nil {
                self.contentArr.addObjectsFromArray(array!)
                print("头条页面数据: = \(self.contentArr.count)")
                print(111111111111111111)
                self.tableView.reloadData()
            }
            HDManager.stopLoading()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeadlineCell:ChangeCurrentPage{
    func changePage(page: Int) {
        self.pageCont.currentPage = page - 1
    }
}

//MARK: - UITableView 的协议方法

extension HeadlineCell:UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HeadCell", forIndexPath: indexPath) as! HeadCell
        let model = self.contentArr[indexPath.row] as! ContentModel
        cell.imgView.sd_setImageWithURL(NSURL.init(string: model.imgUrlList.lastObject as! String))
        cell.titleL.text = model.title
        cell.contentCountL.text = "\(model.pv)" + "人看过"
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // 当点击的时候下载相对应的 json 文件
        let model = self.contentArr[indexPath.row] as! ContentModel
        let web = DetailViewController()
        web.url = PaseFile.paseFile(model.articleUrl)
        self.delegate?.showDetailView(web)
        
    }
    
    
    
}












