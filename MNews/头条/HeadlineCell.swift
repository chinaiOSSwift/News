//
//  HeadlineCell.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HeadlineCell: UICollectionViewCell {
    
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
        let tableView = UITableView.init(frame: CGRectMake(0, 0, Scr_W, Content_H - 10))
        tableView.backgroundColor = UIColor.brownColor()
        tableView.tableHeaderView = self.headView
        self.contentView.addSubview(tableView)
        return tableView
    
    }()
    
   // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.blueColor()
        self.loadData()
    }
    // MARK: - 网络加载数据
    func loadData() -> Void {
        HDManager.startLoading()
        BannerModel.requestBannerData { (array, error) in
            self.bannerArray.addObjectsFromArray(array!)
        }
        ContentModel.requestData { (array, error) in
            self.contentArr.addObjectsFromArray(array!)
            self.tableView.reloadData()
            
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













