//
//  MeViewController.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    // 屏幕宽高
    let screen_width = UIScreen.mainScreen().bounds.width
    let screen_height = UIScreen.mainScreen().bounds.height
    var titleName: String?
    let titlesArr = ["我的收藏","清除缓存"]
    let imageArray = ["favo.png","set.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeUI()
        self.makeLeftBar()
    }
    
    // MARK: - 制作左按钮
    func makeLeftBar() -> Void{
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let view = UIView.init(frame: CGRectMake(0, 0, 200, 30))
        //        view.backgroundColor = UIColor.redColor()
        view.userInteractionEnabled = true
        
        
        let imageView = UIImageView.init(frame: CGRectMake(0, 2, 22, 22))
        imageView.image = UIImage.init(named: "goBack.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        view.addSubview(imageView)
        
        let titleL = UILabel.init(frame: CGRectMake(imageView.mj_x + imageView.mj_w + 3, -2, 150, 30))
        titleL.text = self.titleName
        titleL.textColor = UIColor.blackColor()
        titleL.adjustsFontSizeToFitWidth = true
        titleL.font = UIFont.systemFontOfSize(17)
        titleL.textAlignment = NSTextAlignment.Left
        //        titleL.backgroundColor = UIColor.brownColor()
        view.addSubview(titleL)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.goBack))
        view.addGestureRecognizer(tap)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: view)
    }
    //MARK: -  Nav 左标题的点击事件
    func goBack() -> Void {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - 页面即将显示
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
    }
    
    func makeUI() -> Void {
        
        let tableView = UITableView.init(frame: CGRectMake(0, 0, Scr_W, Scr_H))
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerNib(UINib.init(nibName: "MeCell", bundle: nil), forCellReuseIdentifier: "MeCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        self.view.addSubview(tableView)
        
    }
    
}

// MARK: - UITableView 的协议方法
extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArr.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MeCell", forIndexPath: indexPath) as! MeCell
        cell.titleL.text = self.titlesArr[indexPath.row]
        cell.iconView.image = UIImage.init(named: imageArray[indexPath.row])?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0{
            let favoView = FavoView()
            favoView.dataArr = DataManager.manager.findAll()
            favoView.titleName = "我的收藏"
            favoView.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(favoView, animated: true)
        }else if indexPath.row == 1{
            let ac = UIAlertController.init(title: "⚠️", message: "清除缓存", preferredStyle: .Alert)
            let okAction = UIAlertAction.init(title: "确定", style: .Default, handler: { (action) in
                // 在这里删除数据
                var needDeleteArr = DataManager.manager.findAll()
                for each in needDeleteArr{
                    DataManager.manager.deleteOne(each.title!)
                }
                needDeleteArr.removeAll()
            })
            let cancelAction = UIAlertAction.init(title: "取消", style: .Default, handler: { (action) in
                
            })
            ac.addAction(cancelAction)
            ac.addAction(okAction)
            self.presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
}















