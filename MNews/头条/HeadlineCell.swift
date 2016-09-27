//
//  HeadlineCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol ShowDetail:NSObjectProtocol {
    
    
    // 跳转到webView
    func showDetailView(web:DetailViewController) -> Void
    // 弹出警告框
    func sentMessage(ac:UIAlertController) -> Void
}

class HeadlineCell: BaseCollectionViewCell {
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.channelID = "5572a108b3cdc86cf39001cd"
        self.contentView.backgroundColor = UIColor.whiteColor()
        super.loadData()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    weak var delegate:ShowDetail?
    var pageCont = UIPageControl()
    var bannerArray = NSMutableArray()
    var contentArr = NSMutableArray()
    lazy var headView:UIView = {
        let view = UIView.init(frame: CGRectMake(0, 0, Scr_W,SrcollView_H))
        let scrollView = MyScrollView.init(frame: CGRectMake(0, 0, view.mj_w,view.mj_h), arr: self.bannerArray, isTimer: true)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegator = self
        let pageRect = CGRectMake(view.mj_w - 80, view.mj_h - 20, 80, 20)
        self.pageCont.frame = pageRect
        //                pageCont.backgroundColor = UIColor.whiteColor()
        self.pageCont.numberOfPages = self.bannerArray.count
        if scrollView.currentPage != nil{
            self.pageCont.currentPage = scrollView.currentPage!
            
        }
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
        let url = "http://reader.meizu.com/android/unauth/index/latest_articles.do?articleId=122708732&supportSDK=16&putdate=1474588053000&columnIds=34_1_2_19_20_16_4_37_5_14_9_18_10_7_3_25_23_15_40_41_17_24_26_29_28_30_31_32_21_6&deviceType=MX4&v=2820&operator=46007&nt=wifi&vn=2.8.20&deviceinfo=TD0FxRLgnTr%2FKSlvzaoH%2B0IWG0uV53nTTGKHI68jUHezpZyAXOHYUyswalmpjtGYug1RGYtF4K6OELXz7U5ucKlZfH9PHvV%2BYNrlMOn%2BS5nmOOq4N%2B3mEem%2Bz7HLUN7xiYxfcA7Ea2KxY4lkphp3z%2Fi%2FddTMaH61v9j61JHVqso%3D&os=5.1-1469416338_stable"
        
        HDManager.startLoading()
        BannerModel.requestBannerData { (array, error) in
            if error == nil{
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
    func gotoDetail(web: DetailViewController) {
        self.delegate?.showDetailView(web)
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
        if model.imgUrlList == nil || model.imgUrlList.count == 0{
            
        }else{
            cell.imgView.sd_setImageWithURL(NSURL.init(string: model.imgUrlList.lastObject as! String))
        }
        cell.titleL.text = model.title
        cell.sourceNameL.text = model.contentSourceName
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
        web.titleName = model.contentSourceName
        web.url = PaseFile.paseFile(model.articleUrl)
        self.delegate?.showDetailView(web)
        
    }
    
    */
    
}












