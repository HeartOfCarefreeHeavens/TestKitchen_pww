//
//  KTCDownloder.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

import Alamofire

public enum KTCDownloaderType: Int {
    case Default = 10
    case Recommend    //食材的首页推荐
    case FoodMaterial //首页食材
    case Category     //首页分类
}

protocol KTCDownloaderDelegate:NSObjectProtocol {
    
    func downloader(downloader:KTCDownloder,didFailWithError error:NSError)
    func downloader(downloader:KTCDownloder,didFinishWithData data:NSData?)
    
}


class KTCDownloder: NSObject {

    
    //设置代理属性
    weak var delegate:KTCDownloaderDelegate?
    
    //区分下载类型
    var type:KTCDownloaderType = .Default
    
    //Post请求下载数据
    func postWithUrl(urlString:String,params:Dictionary<String,String>){
    
        var newParam = params
        newParam["token"] = ""
        newParam["user_id"] = ""
        newParam["version"] = "4.5"
        
        Alamofire.request(.POST, urlString, parameters: newParam, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            switch response.result{
            case .Failure(let error):
                
                self.delegate?.downloader(self, didFailWithError: error)
                
            case .Success:
                self.delegate?.downloader(self, didFinishWithData: response.data)
            }
            
        }
        
    }
    
    
}
