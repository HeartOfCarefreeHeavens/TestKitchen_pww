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
    
    //食材课程的数据
    private var serialModel:FoodCourseModel?
    
    //当前选中集数的序号
    private var serialIndex:Int = 0
    
    //集数的cell是合起还是展开
    private var serialIsExpand:Bool = false
    
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
        tbView?.separatorStyle = .None
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
            if serialModel?.data?.data?.count>0 {
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
                //视频的cell
                height = 160
            }else if indexPath.row == 1 {
                //课程标题和描述
                if serialModel?.data?.data?.count>0{
                    let model = serialModel?.data?.data![serialIndex]
                    height = FCCourseCell.heightWithModel(model!)
                }
            }else if indexPath.row == 2 {
                //集数
                height = FCSerialCell.heightWithNum((serialModel?.data?.data?.count)!,isExpand: serialIsExpand)
                
            }
        }else if indexPath.section == 1 {
            
        }
        return height
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            //食材课程的数据
            
            //获取模型对象
            let dataModel = serialModel?.data?.data![serialIndex]

            if indexPath.row == 0 {
                //视频的cell
                cell = createVideoCellForTableView(tableView, atIndexPath: indexPath, withModel: dataModel!)
            }else if indexPath.row == 1 {
                
                //课程名称和描述
                cell = createCourseCellForTableView(tableView, atIndexPath: indexPath, withModel: dataModel!)
            }else if indexPath.row == 2 {
                //集数
                cell = createSerialCellForTableView(tableView, atIndexPath: indexPath, withModel: serialModel!)
            }
        }else if indexPath.section == 1 {
            //评论
        }
        
        cell.selectionStyle = .None
        return cell
    }
    
    /*创建视频的cell*/
    func createVideoCellForTableView(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseSerialModel)->FCVideoCell{
        
        let cellId = "videoCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCVideoCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("FCVideoCell", owner: nil, options: nil).last as? FCVideoCell
        }
        //显示数据
        cell?.model = model
        
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
    
    /*创建课程标题和描述文字的cell*/
    func createCourseCellForTableView(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseSerialModel)->FCCourseCell{
        
        let cellId = "courseCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCCourseCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("FCCourseCell", owner: nil, options: nil).last as? FCCourseCell
        }
        
        cell?.model = model
        
        return cell!
        
    }
    
    
    func createSerialCellForTableView(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseModel)->FCSerialCell{
        
        let cellId = "serialCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCSerialCell
        
        if cell == nil {
            cell = FCSerialCell(style: .Default, reuseIdentifier: cellId)
        }
        
        //传num的代理
        cell?.delegate = self
        
        //
        cell?.isExpand = serialIsExpand

        //显示数据
        cell?.num = model.data?.data?.count
        //设置选中的序号
        cell?.selectIndex = serialIndex
        
        return cell!
    }
    
}

//FCSerialCell的代理
extension FoodCourseController:FCSerialCellDelegate{
    
    func didSelectSerialAtIndex(index: Int) {
        //修改当前选择集数的序号
        serialIndex = index
        
        //刷新表格第一个section的数据
        tbView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
    
    func changeExpandState(isExpand: Bool) {
        
        serialIsExpand = isExpand
        //刷新表格
        tbView?.reloadRowsAtIndexPaths([NSIndexPath(forRow:2 , inSection: 0)], withRowAnimation: .Automatic)
        
        
        
    }
    
}
