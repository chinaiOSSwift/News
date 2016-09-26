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
    var preIndex:NSInteger = 0
    
    lazy var contentHead:UIScrollView = {
        let path = NSBundle.mainBundle().pathForResource("TitleList", ofType: "plist")
        self.titleArr = NSArray.init(contentsOfFile: path!) as! [String]
        let header = UIScrollView.init(frame: CGRectMake(0, 0, Scr_W, btnH))
        for i in 0..<self.titleArr.count{
            let button = UIButton.init(type: UIButtonType.Custom)  // 要用自定义的 否则会有一个蓝色的背景框
            button.frame = CGRectMake(btnW * CGFloat(i), 0, btnW, btnH)
            button.setTitle(self.titleArr[i], forState: UIControlState.Normal)
            button.setTitle(self.titleArr[i], forState: UIControlState.Highlighted)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
            button.titleLabel?.font = UIFont.systemFontOfSize(17)
            button.setTitleColor(NavColor, forState: UIControlState.Selected)
            button.addTarget(self, action: #selector(self.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = 1000 + i
            if button.tag == 1000{
                button.selected = true
            }
            header.addSubview(button)
        }
        header.bounces = false
        header.backgroundColor = UIColor.whiteColor()
        //设置横向滚动条隐藏
        header.showsHorizontalScrollIndicator = false
        header.contentSize = CGSizeMake(CGFloat(self.titleArr.count) * btnW, 0)
        return header
    }()
    // MARK: - 标题点击事件
    func buttonClicked(button:UIButton) -> Void {
        (self.contentHead.viewWithTag(preIndex + 1000) as! UIButton).selected = false
        let buttonTag:NSInteger = button.tag - 1000
        button.selected = true
        self.preIndex = buttonTag
        print("tag = \(button.tag); 下表: = \(buttonTag % 6); x = \(buttonTag % 6) * btnW)")
        UIView.animateWithDuration(0.25) {
            self.sliderView.mj_x = (CGFloat(button.tag - 1000) % 6 + 1) * btnW
        }
        // 改变内容展示
        self.contentView.setContentOffset(CGPointMake(Scr_W * CGFloat(buttonTag), 0), animated: false)
        
        
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
        
        contentView.registerClass(HeadlineCell.self, forCellWithReuseIdentifier: "HeadlineCell") // 1头条
        contentView.registerClass(RecCell.self, forCellWithReuseIdentifier: "RecCell") //2 国际
        contentView.registerClass(EnterCell.self, forCellWithReuseIdentifier: "EnterCell") //3 娱乐
        contentView.registerClass(ScienceCell.self, forCellWithReuseIdentifier: "ScienceCell") //4 科技
        contentView.registerClass(BeautyCell.self, forCellWithReuseIdentifier: "BeautyCell") //5 美女
        contentView.registerClass(SubCell.self, forCellWithReuseIdentifier: "SubCell") //6 教育
        contentView.registerClass(FunnyCell.self, forCellWithReuseIdentifier: "FunnyCell") // 7 CBA最新
        contentView.registerClass(SocialCell.self, forCellWithReuseIdentifier: "SocialCell") //8 社会
        contentView.registerClass(HotCell.self, forCellWithReuseIdentifier: "HotCell") //9 互联网
        contentView.registerClass(SportCell.self, forCellWithReuseIdentifier: "SportCell") //10 体育
        contentView.registerClass(FocusCell.self, forCellWithReuseIdentifier: "FocusCell") //11 国内
        
        contentView.registerClass(FinanceCell.self, forCellWithReuseIdentifier: "FinanceCell") //12 财经
        contentView.registerClass(MilitaryCell.self, forCellWithReuseIdentifier: "MilitaryCell") //13 军事
        contentView.registerClass(HistoryCell.self, forCellWithReuseIdentifier: "HistoryCell") //14 房产
        contentView.registerClass(CarCell.self, forCellWithReuseIdentifier: "CarCell") //15 汽车
        contentView.registerClass(HealthHCell.self, forCellWithReuseIdentifier: "HealthHCell") //16 健康
        contentView.registerClass(SexesCell.self, forCellWithReuseIdentifier: "SexesCell") //17 两性
        contentView.registerClass(MovieCell.self, forCellWithReuseIdentifier: "MovieCell") //18 影视
        contentView.registerClass(SeriesCell.self, forCellWithReuseIdentifier: "SeriesCell") // 19电视剧
        contentView.registerClass(GameCell.self, forCellWithReuseIdentifier: "GameCell") //20 游戏
        
        
        
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
        var cellID = "FocusCell"
        if indexPath.item == 0{  // 1 头条
            cellID = "HeadlineCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! HeadlineCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 1{  //2 国际最新
            cellID = "RecCell"
            let  cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! RecCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 2{  //3 娱乐
            cellID = "EnterCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! EnterCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 3{ //4 科技
            cellID = "ScienceCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! ScienceCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 4{ //5 美女
            cellID = "BeautyCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! BeautyCell
            return cell
            
        }else if indexPath.item == 5{ //6 教育
            cellID = "SubCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! SubCell
            return cell
        }else if indexPath.item == 6{ //7 CBA最新
            cellID = "FunnyCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! FunnyCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 7{ //8 社会
            cellID = "SocialCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! SocialCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 8{ //9 互联网
            cellID = "HotCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! HotCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 9{ //10 体育
            cellID = "SportCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! SportCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 10{ //11 国内
            cellID = "FocusCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! FocusCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 11{ //12 财经
            cellID = "FinanceCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! FinanceCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 12{ //13 军事
            cellID = "MilitaryCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! MilitaryCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 13{ //14 房产
            cellID = "HistoryCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! HistoryCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 14{ //15 汽车
            cellID = "CarCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! CarCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 15{ //16 健康
            cellID = "HealthHCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! HealthHCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 16{ //17 两性
            cellID = "SexesCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! SexesCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 17{ //18 影视
            cellID = "MovieCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! MovieCell
            cell.delegate = self
            return cell
        }else if indexPath.item == 18{ //19 电视剧
            cellID = "SeriesCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! SeriesCell
            cell.delegate = self
            return cell
        }else{ //20 游戏
            cellID = "GameCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! GameCell
            print("应该执行了")
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
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
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        (self.contentHead.viewWithTag(preIndex + 1000) as! UIButton).selected = false
        let currentIndex = NSInteger(scrollView.contentOffset.x / Scr_W)
        (self.contentHead.viewWithTag(currentIndex + 1000) as! UIButton).selected = true
        self.preIndex = currentIndex
        print("当前第 \(currentIndex) 界面")
        
        if scrollView.contentOffset.x > 6 * Scr_W{
            UIView.animateWithDuration(0.25, animations: {
                self.contentHead.setContentOffset(CGPointMake(CGFloat(currentIndex - 5) * btnW, 0), animated: true)
            })
            
        }else if scrollView.contentOffset.x == CGFloat(6) * Scr_W{
            UIView.animateWithDuration(0.25, animations: {
                self.contentHead.setContentOffset(CGPointMake(0, 0), animated: true)
            })
            
        }
        
        
    }
    
    
    
}

extension ViewController: ShowDetail{
    func showDetailView(web:DetailViewController){
        self.navigationController?.pushViewController(web, animated: true)
    }
    
}



















