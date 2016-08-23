//
//  CookbookViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CookbookViewController: BaseViewController {

    
    //食材首页推荐视图
    private var recommendView:CBRecommendView?
    //首页食材视图
    private var foodView:CBMaterialView?
    //首页分类视图
    private var categoryView:CBMaterialView?
    //导航的标题视图
    private var segCtrl:KTCSegmentCtrl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createMyNav()
        self.createHomePageView()
        downloadRecommendData()
        downloadFoodData()
        
    }
    
    //下载食材的数据
    func downloadFoodData(){
        
        //参数
        let dict = ["methodName":"MaterialSubtype"]
        let downloader = KTCDownloder()
        downloader.delegate = self
        downloader.type = .FoodMaterial
        downloader.postWithUrl(kHostUrl, params: dict)
        
    }
    
    
    //初始化视图
    func createHomePageView(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //1.创建滚动视图
        let scrollView = UIScrollView()
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        
        //给滚动视图添加约束
        scrollView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        
        //2.创建容器视图
        let containerView = UIView.createView()
        scrollView.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
            
        }
        
        
        
        //推荐
        recommendView = CBRecommendView()
        containerView.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: {
            (make) in
            
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo(containerView)
            
            
        })
        
        //食材
        foodView = CBMaterialView()
        foodView?.backgroundColor = UIColor.redColor()
        containerView.addSubview(foodView!)
        foodView?.snp_makeConstraints(closure: { (make) in
            
            make.top.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((recommendView?.snp_right)!)
            
        })
        
        
        
        
        //分类
        categoryView = CBMaterialView()
        categoryView?.backgroundColor = UIColor.purpleColor()
        containerView.addSubview(categoryView!)
        categoryView?.snp_makeConstraints(closure: { (make) in
            
            make.top.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((foodView?.snp_right)!)
            
            
        })
        
        //修改容器视图的大小
        containerView.snp_makeConstraints { (make) in
            
            make.right.equalTo(categoryView!)
        }
        
        
        
    }
    
    //下载推荐数据
    func downloadRecommendData(){

        let dict = ["methodName":"SceneHome"]
        
        let downloader = KTCDownloder()
        downloader.type = .Recommend
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: dict)
        
    }
    
    //导航视图
    func createMyNav(){
        
        //标题位置
        segCtrl = KTCSegmentCtrl(frame: CGRectMake(80, 0, kScreenWidth-80*2, 44), titleNames: ["推荐","食材","分类"])
        navigationItem.titleView = segCtrl
        
        
        //扫一扫功能
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        //搜索功能
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
        
    }
    
    func scanAction(){
        
    }
    
    func searchAction(){
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CookbookViewController:KTCDownloaderDelegate{
    
    func downloader(downloader: KTCDownloder, didFailWithError error: NSError) {
        
    }
    
    func downloader(downloader: KTCDownloder, didFinishWithData data: NSData?) {
        
        if downloader.type == .Recommend  {
            if let jsonData = data {
                let model = CBRecommendModel.parseModel(jsonData)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    [weak self] in
                    self!.recommendView?.model = model
                    
                    })
            }

        }else if downloader.type == .FoodMaterial{
            
//            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(str!)
            if let jsonData = data {
                let model = CBMaterialModel.parseModelWithData(jsonData)
                
                print(model)
                
            }
            
        }else if downloader.type == .Category{
            
        }
        
        
        
        
        
    }
    
    
}

