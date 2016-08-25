//
//  FoodCourseController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class FoodCourseController: BaseViewController {
    
    //id
    var serialId:String?
    
    private var tbView:UITableView?
    
    private var serialModel:FoodCourseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        creatMyNav()
        createTableView()
        downloadFoodCourseData()
        
    }
    
    
    //下载食课数据
    func downloadFoodCourseData(){
        var dict = Dictionary<String,String>()
        dict["methodName"] = "CourseSeriesView"
        dict["series_id"] = serialId
        
        let downloader = KTCDownloder()
        downloader.delegate = self
        downloader.type = .FoodCourse
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    
    
    //导航
    func creatMyNav(){
        
        //返回按钮
        addNavBackBtn()
    }
    
    //创建表格
    func createTableView(){
        
        self.automaticallyAdjustsScrollViewInsets = false 
        tbView = UITableView(frame: CGRectMake(0, 64, kScreenWidth, kScreenHeight-64), style: .Plain)
        
        tbView?.delegate = self
        tbView?.dataSource = self
        view.addSubview(tbView!)
        
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

//KTCDownloader的代理
extension FoodCourseController:KTCDownloaderDelegate{
    func downloader(downloader: KTCDownloder, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloader(downloader: KTCDownloder, didFinishWithData data: NSData?) {
        if downloader.type == .FoodCourse{
            //食课数据
//            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(str!)
            if let jsonData = data{
                let model = FoodCourseModel.parseModel(jsonData)
                serialModel = model
                
                //回到主线程刷新
                dispatch_async(dispatch_get_main_queue(), { 
                    
                    [weak self] in
                    self!.tbView?.reloadData()
                })
            }
            
            
        }else if downloader.type == .FoodCourseComment{
            
            
        }
    }
}


//UITableView代理
extension FoodCourseController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if section == 0 {
            //食材数据
            if serialModel != nil {
                rowNum = 3
            }
        }else if section == 1{
            
        }
        return rowNum
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                height = 160
            }
        }else if indexPath.section == 1 {
            
        }
        return height
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            //食材课程的数据
            if indexPath.row == 0 {
                //视频的cell 
                let cellId = "videoCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCVideoCell
                if cell == nil {
                    cell = NSBundle.mainBundle().loadNibNamed("FCVideoCell", owner: nil, options: nil).last as? FCVideoCell
                }
                
                let videoModel = serialModel?.data?.data![0]
                cell?.model = videoModel
                
                cell?.videoClosure = {
                    (urlString) in
                    let url = NSURL(string: urlString)
                    let player = AVPlayer(URL: url!)
                    let playerCtrl = AVPlayerViewController()
                    playerCtrl.player = player
                    player.play()
                    
                    self.presentViewController(playerCtrl, animated: true, completion: nil)
                    
                }
                
                return cell!
                
            }
        }else if indexPath == 1 {
            //评论
        }
        return UITableViewCell()
    }
    
    
}

