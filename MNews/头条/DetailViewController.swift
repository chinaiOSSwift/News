//
//  DetailViewController.swift
//  MNews
//
//  Created by qianfeng on 16/9/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let web = UIWebView.init(frame: CGRectMake(0, 0, Scr_W, Scr_H))
        web.backgroundColor = ContentColor
        web.loadRequest(NSURLRequest.init(URL: NSURL.init(string: url!)!))
        self.view.addSubview(web)
        
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
