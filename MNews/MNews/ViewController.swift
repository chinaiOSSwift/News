//
//  ViewController.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var btnW:CGFloat = 0// 按钮的宽度
    var space:CGFloat = 10// 距离屏幕左端的距离
    var topSpace:CGFloat = 0 // 距离最顶端的距离
    var btnH:CGFloat = 30// 按钮的高度
    var sliderView:UIView! // 小滑块
    var titleArray = NSMutableArray() // 标题数组
    var titleCollectionView:UICollectionView!
    
    lazy var contentHead:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        let header = UICollectionView.init(frame: CGRectMake(0, 0, Scr_W, self.btnH), collectionViewLayout: layout)
//        header.delegate = self
//        header.dataSource = self
        header.backgroundColor = UIColor.brownColor()
        header.registerNib(UINib.init(nibName: "TitleCell", bundle: nil), forCellWithReuseIdentifier: "TitleCell")
        //设置横向滚动条隐藏
        header.showsHorizontalScrollIndicator = false
        return header
        
    }()
    
    // MARK: - 展示内容视图
    lazy var contentView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        // 滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        let contentView = UICollectionView.init(frame: CGRectMake(0, 67 + self.btnH, Scr_W, Scr_H - 67 + self.btnH), collectionViewLayout: layout)
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
//        contentView.bounces = false
        contentView.delegate = self
        contentView.dataSource = self
        self.view.addSubview(contentView)
        return contentView
        
        
    }()
    
    
    
    
    
    // MARK: - 页面加载
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.userInteractionEnabled = true
        self.btnW = Scr_W / 6
        self.view.backgroundColor = UIColor.whiteColor()
        self.makeNavi()
        self.loadData()
        self.makeHeadView()
        
        
        
    }
    
    
    //MARK: - 创建头视图
    func makeHeadView() -> Void {
        let head = UIView.init(frame: CGRectMake(0, 64, Scr_W, btnH + 3))
        self.sliderView = UIView.init(frame: CGRectMake(0, head.mj_h - 3, self.btnW, 2))
        self.sliderView.backgroundColor = UIColor.blueColor()
        head.addSubview(self.sliderView)
        head.addSubview(self.contentHead)
        //        head.backgroundColor = UIColor.orangeColor()
        
        
        
        
        
        // 添加下面的灰色的线
        let view = UIView.init(frame: CGRectMake(0, head.mj_h - 1, Scr_W, 1))
        view.backgroundColor = UIColor.grayColor()
        head.addSubview(view)
        self.view.addSubview(head)
    }
    
    // MARK: - 网络请求
    func loadData() -> Void {
        
        HDManager.startLoading()
        TitleModel.requestTitleData { (titleArr, error) in
            self.titleArray.addObjectsFromArray(titleArr!)
            self.contentHead.reloadData()
            
            self.contentView.reloadData()
            
        }
        HDManager.stopLoading()
        
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
//        if collectionView == self.contentHead{
//            return titleArray.count
//        }
        return 4
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        if collectionView == self.contentHead{
//            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
//            let model = titleArray[indexPath.row] as! TitleModel
//            cell.titleL.text = model.name
//            cell.titleL.sizeToFit()
//            return cell
//        }
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
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
        if collectionView == self.contentHead{
            print("标题 = \((self.titleArray[indexPath.row] as! TitleModel).name)")
            UIView.animateWithDuration(0.25) {
                self.sliderView.mj_x = self.btnW * (CGFloat(indexPath.row) % 6)
            }
        }
        
    }
    
    
    
    
    
    
}




















