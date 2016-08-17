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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createMyNav()
        self.createHomePageView()
        downloadRecommendData()
        
    }
    
    //初始化视图
    func createHomePageView(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        recommendView = CBRecommendView()
        view.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            
            
            
        })
        
    }
    
    //下载推荐数据
    func downloadRecommendData(){

        let dict = ["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        
        let downloader = KTCDownloder()
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: dict)
        
    }
    
    //导航视图
    func createMyNav(){
        
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
        
        if let jsonData = data {
            let model = CBRecommendModel.parseModel(jsonData)
            
            dispatch_async(dispatch_get_main_queue(), { 
                
                [weak self] in
                self!.recommendView?.model = model
                
            })
        }
        
        
        
    }
    
    
}

