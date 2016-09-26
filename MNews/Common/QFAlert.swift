//
//  QFAlert.swift
//  a25WanYanYong
//
//  Created by qianfeng on 16/9/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class QFAlert: NSObject {

    static func alert(message:String) -> UIAlertController{
        let ac = UIAlertController.init(title: "", message: message, preferredStyle: .Alert)
        let action = UIAlertAction.init(title: "确定", style: .Default) { (action) in
            
        }
        ac.addAction(action)
        return ac
    }
    
}
