//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    private var bgView:UIView?
    private var array:Array<Dictionary<String,String>>?{
        //异常处理
        get{
            let path =  NSBundle.mainBundle().pathForResource("Ctrl.json", ofType: nil)
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
        var imageNames = [String]()
        var titleNames = [String]()
        
        if let tmpArray = self.array{
            
            for dict in tmpArray{
                let name = dict["ctrlName"]
                let title = dict["titleName"]
                let imageName = dict["imageName"]
                ctrlNames.append(name!)
                titleNames.append(title!)
                imageNames.append(imageName!)
            }

        }else{
            ctrlNames = ["CookbookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
            
            //home_normal@2x   home_select@2x
            //community_normal@2x community_select@2x
            //shop_normal@2x  shop_select@2x
            //shike_normal@2x  shike_select@2x
            //mine_normal@2x   mine_select@2x
            
            //文字数组
            titleNames = ["食材","社区","商城","食课","我的"]
            //图片数组
            imageNames = ["home","community","shop","shike","mine"]
            

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
        self.createCustomTabbar(titleNames, imageNames: imageNames)
    }
    
    
    
    //自定制tabbar
    
    func createCustomTabbar(titleNames:[String],imageNames:[String]){
        
        bgView = UIView()
        bgView?.backgroundColor = UIColor.whiteColor()
        bgView?.layer.borderWidth = 1
        bgView?.layer.borderColor = UIColor.grayColor().CGColor
        view.addSubview(bgView!)
        //bgView约束
        bgView?.snp_makeConstraints(closure:{
            
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view.snp_bottom).offset(-49)
            
            
        })
        
        //循环创建按钮
        let with = kScreenWidth/5.0
        for i in 0..<imageNames.count {
            
            let imageName = imageNames[i]
            let titleName = titleNames[i]
            
            //按钮
            let bgImageName = imageName + "_normal"
            let selectBgImageName = imageName + "_select"
            let btn = UIButton.createBtn(nil, bgImageName: bgImageName, selectBgImageName: selectBgImageName, target: self, action: #selector(clickBtn(_:)))
            bgView?.addSubview(btn)
            //btn的位置(添加约束)
            btn.snp_makeConstraints(closure: {
                
                (make) in
                make.top.bottom.equalTo(self.bgView!)
                make.width.equalTo(with)
                make.left.equalTo(with*CGFloat(i))
                
                
            })
            //文字
            
            let label = UILabel.createLabel(titleName, font: UIFont.systemFontOfSize(8), textAlignment: .Center, textColor: UIColor.grayColor())
            btn.addSubview(label)
            
            //约束
            label.snp_makeConstraints(closure: { (make) in
                
                make.left.right.equalTo(btn)
                make.top.equalTo(btn).offset(32)
                make.height.equalTo(12)
                
            })
            
            btn.tag = 300 + i
            label.tag = 400
            if i == 0 {
                btn.selected = true
                label.textColor = UIColor.orangeColor()
            }
        }
    }

    func clickBtn(curBtn:UIButton){
        
        let lastBtnView = self.view.viewWithTag(300+selectedIndex)
        if let tmpBtn = lastBtnView {
            //上次选中的按钮
            let lastBtn = tmpBtn as! UIButton
            let lastView = tmpBtn.viewWithTag(400)
            if let tmpLabel = lastView{
                //上次选中的标签
                let lastLabel = tmpLabel as! UILabel
                lastBtn.selected = false
                lastLabel.textColor = UIColor.grayColor()
            }
        }
        
        //设置当前选中按钮的状态
        let curLabelView = curBtn.viewWithTag(400)
        if let tmpLabel = curLabelView{
            let curLabel = tmpLabel as! UILabel
            curBtn.selected = true
            curLabel.textColor = UIColor.orangeColor()
        }
        
        //选中视图控制器
        selectedIndex = curBtn.tag - 300
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
}
