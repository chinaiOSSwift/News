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
        HDManager.startLoading()
        BannerModel.requestBannerData { (array, error) in
            self.bannerArray.addObjectsFromArray(array!)
            print(00000000000000000)
        }
        ContentModel.requestData { (array, error) in
            self.contentArr.addObjectsFromArray(array!)
            print(111111111111111111)
            self.tableView.reloadData()
            print("count = \(self.contentArr.count)")
        }
        
        HDManager.stopLoading()
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
        cell.contentCountL.text = "\(model.commentCount)" + "人看过"
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












