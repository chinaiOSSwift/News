//
//  DetailViewController.swift
//  MNews
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var model:BaseModel?
    var url:String?
    var titleName:String?
    var flag:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeLeftBar()
        self.makeUI()
    }
    
    func makeUI() -> Void {
        let button = UIButton.init(type: .System)
        button.frame = CGRectMake(0, 0, 30, 30)
        button.setImage(UIImage.init(named: "icon_star@2x.png")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        button.addTarget(self, action: #selector(self.buttonClick(_:)), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        if DataManager.manager.findOne(self.model!.title!){
            button.setImage(UIImage.init(named: "icon_star_full@2x.png")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
            flag = true
        }
    }
    
    func buttonClick(sender:UIButton) -> Void {
        
        if !flag{
            DataManager.manager.insert(model!)
            self.presentViewController(QFAlert.alert("收藏成功"), animated: true, completion: nil)
            sender.setImage(UIImage.init(named: "icon_star_full@2x.png")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        }else{
            print("移除收藏")
            DataManager.manager.deleteOne(self.model!.title!)
            sender.setImage(UIImage.init(named: "icon_star@2x.png")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        }
        flag = !flag
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let web = UIWebView.init(frame: CGRectMake(0, 0, Scr_W, Scr_H))
        web.backgroundColor = ContentColor
        web.loadRequest(NSURLRequest.init(URL: NSURL.init(string: model!.link)!))
        self.view.addSubview(web)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
