//
//  CBMaterialModel.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import SwiftyJSON
class CBMaterialModel: NSObject {

    var code:String?
    var msg:String?
    var version:String?
    var timestamp:NSNumber?
    var data:CBMaterialDataModel?
    class func parseModelWithData(data:NSData)->CBMaterialModel{
        let jsonData = JSON(data:data)
        let model = CBMaterialModel()
        model.code = jsonData["code"].string
        model.msg = jsonData["msg"].string
        model.version = jsonData["version"].string
        model.timestamp = jsonData["timestamp"].number
        let dataJson = jsonData["data"]
        model.data = CBMaterialDataModel.paseModel(dataJson)
        return model
    }
    
}

class CBMaterialDataModel:NSObject{
    
    var id:NSNumber?
    var text:String?
    var name:String?
    var data:Array<CBMaterialTypeModel>?
    
    class func paseModel(jsonData:JSON)->CBMaterialDataModel{
        let model = CBMaterialDataModel()
        model.id = jsonData["id"].number
        model.text = jsonData["text"].string
        model.name = jsonData["name"].string
        let dataArray = jsonData["data"]
        var array = Array<CBMaterialTypeModel>()
        for (_,subjson) in dataArray{
            let typeModel = CBMaterialTypeModel.parseModel(subjson)
            array.append(typeModel)
        }
        model.data = array
        return model
    }
    
    
    
}

class CBMaterialTypeModel:NSObject{
    
    var id:String?
    var text:String?
    var image:String?
    var data:Array<CBMaterialSubtypeModel>?
    
    class func parseModel(jsonData:JSON)->CBMaterialTypeModel{
        let model = CBMaterialTypeModel()
        model.id = jsonData["id"].string
        model.text = jsonData["text"].string
        model.image = jsonData["image"].string
        let dataArray = jsonData["data"]
        var array = Array<CBMaterialSubtypeModel>()
        for (_,subjson) in dataArray {
            let subtypeModel = CBMaterialSubtypeModel.parseModel(subjson)
            array.append(subtypeModel)
            
        }
        model.data = array
        return model
    }
    
}

class CBMaterialSubtypeModel:NSObject{
    
    var id:String?
    var text:String?
    var image:String?
    
    class func parseModel(jsonData:JSON)->CBMaterialSubtypeModel{
        let model = CBMaterialSubtypeModel()
        model.id = jsonData["id"].string
        model.text = jsonData["text"].string
        model.image = jsonData["image"].string
        
        return model
        
    }
    
}
