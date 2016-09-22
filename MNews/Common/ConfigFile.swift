//
//  ConfigFile.swift
//  MNews
//
//  Created by qianfeng on 16/9/21.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import UIKit

let NavColor:UIColor = UIColor.init(red: 65 / 255.0, green: 108 / 255.0, blue: 233 / 255.0, alpha: 1.0)
let ContentColor:UIColor = UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)


let Scr_W = UIScreen.mainScreen().bounds.width
let Scr_H = UIScreen.mainScreen().bounds.height
// 滚动条的高度
let SrcollView_H:CGFloat = 200

var btnW:CGFloat = 0// 按钮的宽度
var space:CGFloat = 10// 距离屏幕左端的距离
var topSpace:CGFloat = 0 // 距离最顶端的距离
var btnH:CGFloat = 30// 按钮的高度
// 展示内容的高度  去掉 Nan - btnH 
let Content_H = UIScreen.mainScreen().bounds.height - 64 - btnH









