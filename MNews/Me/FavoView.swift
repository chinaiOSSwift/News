//
//  FavoView.swift
//  a25WanYanYong
//
//  Created by qianfeng on 16/9/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FavoView: UIViewController {
    
    let tableView = UITableView()
    var dataArr = [BaseModel]()
    var titleName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeLeftBar()
        self.makeUI()
        self.isFavo()
    }
    func makeUI() -> Void {
        self.view.backgroundColor = UIColor.grayColor()
        tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        
        tableView.registerNib(UINib.init(nibName: "BaseZeroCell", bundle: nil), forCellReuseIdentifier: "BaseZeroCell")
        self.view.addSubview(tableView)
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
    
    
    // MARK: - 判断收藏数组时候为空
    func isFavo() -> Void {
        if self.dataArr.count == 0{
            let netView = UIView.init(frame:CGRectMake(0, 0, Scr_W , Scr_H))
            netView.center = self.view.center
            //                    netView.backgroundColor = UIColor.redColor()
            let imageView = UIImageView.init(frame: CGRectMake(0, 0, 50, 50))
            imageView.mj_x = netView.center.x - 25
            imageView.mj_y = netView.center.y - 100
            imageView.image = UIImage.init(named: "no_favo.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            //                    imageView.backgroundColor = UIColor.greenColor()
            let tipL = UILabel.init(frame: CGRectMake(0, 0, 300, 23))
            tipL.mj_x = imageView.center.x - 150
            tipL.mj_y = imageView.mj_y + imageView.mj_h + 5
            //        tipL.backgroundColor = UIColor.brownColor()
            tipL.font = UIFont.systemFontOfSize(17)
            tipL.text =  "暂无收藏"
            tipL.textAlignment = NSTextAlignment.Center
            tipL.textColor = NavColor
            netView.addSubview(tipL)
            netView.addSubview(imageView)
            self.view.addSubview(netView)
        }
    }
}

// MARK: - UITableView 协议方法
extension FavoView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BaseZeroCell", forIndexPath: indexPath) as! BaseZeroCell
        let model = self.dataArr[indexPath.row]
        cell.customCellWithDic(model)
        return cell
    }
    
    // 返回中文汉字
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }
    //左滑出现删除按钮
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    //
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            DataManager.manager.deleteOne(dataArr[indexPath.row].title!)
            dataArr.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.reloadData()
            self.isFavo()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let web = DetailViewController()
        web.model = self.dataArr[indexPath.row]
        web.titleName = self.dataArr[indexPath.row].source
        web.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(web, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Content_H / 6
    }
    
    
    
    
}
