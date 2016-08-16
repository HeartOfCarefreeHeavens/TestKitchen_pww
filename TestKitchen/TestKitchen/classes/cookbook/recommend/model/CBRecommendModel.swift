//
//  CBRecommendModel.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBRecommendModel: NSObject {

    var code:NSNumber?
    var msg:Bool?
    var version:String?
    var timestamp:NSNumber?
    var data:NSDictionary?
    
    
}

class CBRecommendDataModel:NSObject{
    
    var banner:Array<CBRecommendBannerModel>?
    var widgetList:Array<CBRecommendWidgetListModel>?
    
}


class CBRecommendBannerModel: NSObject {
    
    var banner_id:NSNumber?
    var banner_title:String?
    var banner_picture:String?
    var banner_link:String?
    var is_link:NSNumber?
    var refer_key:NSNumber?
    var type_id:NSNumber?
    
}

class CBRecommendWidgetListModel: NSObject {
    
    
    var widget_id:NSNumber?
    var widget_type:NSNumber?
    var title:String?
    var title_link:String?
    var desc:String?
    var widget_data:Array<CBRecommendWidgetdataModel>?
    
}

class CBRecommendWidgetdataModel: NSObject {
    
    var id:NSNumber?
    var type:String?
    var content:String?
    var link:String?
    
    
}



