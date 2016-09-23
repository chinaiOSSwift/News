//
//  ViewController.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var sliderView:UIView! // 小滑块
    var titleArr = [String]()
    var titleCollectionView:UICollectionView!
    
    lazy var contentHead:UIScrollView = {
        let path = NSBundle.mainBundle().pathForResource("TitleList", ofType: "plist")
        self.titleArr = NSArray.init(contentsOfFile: path!) as! [String]
        let header = UIScrollView.init(frame: CGRectMake(0, 0, Scr_W, btnH))
        for i in 0..<self.titleArr.count{
            let button = UIButton.init(type: .System)
            button.frame = CGRectMake(btnW * CGFloat(i), 0, btnW, btnH)
            button.backgroundColor = UIColor.redColor()
            button.setTitle(self.titleArr[i], forState: UIControlState.Normal)
            button.setTitle(self.titleArr[i], forState: UIControlState.Highlighted)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            button.titleLabel?.font = UIFont.systemFontOfSize(17)
            button.setTitleColor(NavColor, forState: UIControlState.Selected)
            button.addTarget(self, action: #selector(self.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = 1000 + i
            if i % 2 == 0{
                button.backgroundColor = UIColor.whiteColor()
            }
            header.addSubview(button)
        }
        header.bounces = false
        header.backgroundColor = UIColor.brownColor()
        //设置横向滚动条隐藏
        header.showsHorizontalScrollIndicator = false
        header.contentSize = CGSizeMake(CGFloat(self.titleArr.count) * btnW, 0)
        return header
    }()
    // MARK: - 标题点击事件
    func buttonClicked(button:UIButton) -> Void {
        print("tag = \(button.tag); 下表: = \((button.tag - 1000) % 6); x = \((CGFloat(button.tag - 1000) % 6) * btnW)")
        UIView.animateWithDuration(0.25) {
            self.sliderView.mj_x = (CGFloat(button.tag - 1000) % 6) * btnW
        }
    }
    
    
    // MARK: - 展示内容视图
    lazy var contentView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        // 滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        let contentView = UICollectionView.init(frame: CGRectMake(0, 67 + btnH, Scr_W, Scr_H - 67 + btnH), collectionViewLayout: layout)
        contentView.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        //
        contentView.showsHorizontalScrollIndicator = false
        contentView.pagingEnabled = true
        //注册界面
        contentView.registerClass(ScienceCell.self, forCellWithReuseIdentifier: "ScienceCell")
        contentView.registerClass(HeadlineCell.self, forCellWithReuseIdentifier: "HeadlineCell")
        contentView.registerClass(RecCell.self, forCellWithReuseIdentifier: "RecCell")
        contentView.registerClass(EnterCell.self, forCellWithReuseIdentifier: "EnterCell")
        contentView.contentOffset = CGPointZero
        contentView.bounces = false
        contentView.delegate = self
        contentView.dataSource = self
        self.view.addSubview(contentView)
        return contentView
    }()
    
    // MARK: - 页面加载
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.userInteractionEnabled = true
        btnW = Scr_W / 6
        self.view.backgroundColor = UIColor.whiteColor()
        self.makeNavi()
        self.makeHeadView()
        self.contentView.reloadData()
    }
    //MARK: - 创建头视图
    func makeHeadView() -> Void {
        let head = UIView.init(frame: CGRectMake(0, 64, Scr_W, btnH + 3))
        self.sliderView = UIView.init(frame: CGRectMake(0, head.mj_h - 3, btnW, 2))
        self.sliderView.backgroundColor = UIColor.blueColor()
        head.addSubview(self.sliderView)
        head.addSubview(self.contentHead)
        //head.backgroundColor = UIColor.orangeColor()
        
        // 添加下面的灰色的线
        let view = UIView.init(frame: CGRectMake(0, head.mj_h - 1, Scr_W, 1))
        view.backgroundColor = UIColor.grayColor()
        head.addSubview(view)
        self.view.addSubview(head)
    }
    // MARK: - 定制 导航条
    func makeNavi() -> Void {
        self.navigationController?.navigationBar.barTintColor = NavColor
        let titleL = UILabel.init(frame: CGRectMake(0, 0, 80, 44))
        titleL.textAlignment = NSTextAlignment.Left
        titleL.text = "新闻快递"
        titleL.textColor = UIColor.whiteColor()
        titleL.font = UIFont.systemFontOfSize(17)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleL)
        // 个人中心
        let button = UIButton.init(type: UIButtonType.System)
        button.frame = CGRectMake(0, 0, 30, 30)
        button.setBackgroundImage(UIImage.init(named: "me.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage.init(named: "me.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Highlighted)
        button.setBackgroundImage(UIImage.init(named: "me.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: UIControlState.Selected)
        button.addTarget(self, action: #selector(self.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    
    //MARK: - 个人中心点击事件
    func btnClick(button:UIButton) -> Void {
        let me = MeViewController()
        self.navigationController?.pushViewController(me, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UICollectionView 协议方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cellID = ""
        if indexPath.item == 0{
            cellID = "HeadlineCell"
        }else if indexPath.item == 1{
            cellID = "RecCell"
        }else if indexPath.item == 2{
            cellID = "EnterCell"
        }else if indexPath.item == 3{
            cellID = "ScienceCell"
        }
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
        if indexPath.item == 0{
            let cell1 = cell as! HeadlineCell
            cell1.delegate = self
        }else if indexPath.item == 3{
            let cell2 = cell as! ScienceCell
            cell2.delegate = self
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //        if collectionView == self.contentHead{
        //            return CGSizeMake(self.btnW, self.btnH)
        //        }
        return CGSizeMake(collectionView.mj_w, collectionView.mj_h)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
    
    
}

extension ViewController: ShowDetail{
    func showDetailView(web:DetailViewController){
        self.navigationController?.pushViewController(web, animated: true)
    }
    
}



















