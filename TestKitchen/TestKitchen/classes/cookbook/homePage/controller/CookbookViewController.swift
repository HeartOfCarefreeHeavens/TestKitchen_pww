//
//  CookbookViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CookbookViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createMyNav()
        self.downloadRecommendData()
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
        print(error)
        
    }
    
    func downloader(downloader: KTCDownloder, didFinishWithData data: NSData?) {
        
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(str)
        
    }
    
    
}

