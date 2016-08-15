//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    private var array:Array<Dictionary<String,String>>?{
        //异常处理
        get{
            let path = NSBundle.mainBundle().pathForResource("Ctrl.json", ofType: nil)
            var myArray:Array<Dictionary<String,String>>? = nil
            if let filePath = path{
                let data = NSData(contentsOfFile: filePath)
                if let jsonData = data{
                    do{
                        let jsonValue =  try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
                        if jsonValue.isKindOfClass(NSArray.self){
                            myArray = jsonValue as? Array<Dictionary<String,String>>
                        }

                    }catch{
                        //程序出现异常
                        print(error)
                        return nil
                    }

                }
            }
            return myArray
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createViewControllers()
        
    }
    
    //创建视图控制器
    func createViewControllers(){
        
        var ctrlNames = [String]()
        if let tmpArray = self.array{
            for dict in tmpArray {
                let name = dict["ctrlName"]
                ctrlNames.append(name!)
            }

        }else{
            ctrlNames = ["CookbookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]

        }
        var vCtrlArray = Array<UINavigationController>()
        for i in 0..<ctrlNames.count{
            
            //创建视图控制器
            let ctrlName = "TestKitchen." + ctrlNames[i]
            let cls = NSClassFromString(ctrlName) as! UIViewController.Type
            let ctrl = cls.init()
            
            //导航
            let navCtrl = UINavigationController(rootViewController: ctrl)
            vCtrlArray.append(navCtrl)
            
        }
        self.viewControllers = vCtrlArray
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
