//
//  Util.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

//这个文件用来定义枚举和其他类型

//1.食材首页推荐的数据类型

public enum widgetType:Int{
    
    case GuessYourLike = 1 //猜你喜欢
    case RedPackage = 2 //红包入口
    case NewProduct = 5 //今日新品
    case Special = 3 //早餐日记,健康100岁
    case Scene = 9 //全部场景
    case Talent = 4 //推荐达人
    case Works = 8 //精选作品
    case Subject = 7 //专题

}

//2.食材首页推荐的cell的点击事件闭包的类型

/*
 闭包参数
 (1)标题文字
 (2)link字符串
 */
public typealias CBCellClosure = (String?,String)->Void