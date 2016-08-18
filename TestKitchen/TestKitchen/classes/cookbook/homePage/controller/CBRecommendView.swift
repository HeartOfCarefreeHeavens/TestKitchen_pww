//
//  CBRecommendView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBRecommendView: UIView {

    
    private var tbView :UITableView?
    
    var model:CBRecommendModel?{
        
        didSet{
            tbView?.reloadData()
        }
        
    }
    
    init() {
        super.init(frame: CGRectZero)
        
        tbView = UITableView(frame: CGRectZero,style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        
        //分割线设置为none
        tbView?.separatorStyle = .None
        
        self.addSubview(tbView!)
        
        
        //设置约束(自动布局)
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            
            make.edges.equalTo(self!)
            
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CBRecommendView:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //广告数据显示一个分组
        var sectionNum = 1
        if model?.data?.widgetList?.count>0{
            
            sectionNum += (model?.data?.widgetList?.count)!
 
        }
        return sectionNum
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if section == 0 {
            if model?.data?.banner?.count>0{
                rowNum = 1
            }
        }else{
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue {
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == widgetType.RedPackage.rawValue {
                rowNum = 1
            }

        }
        return rowNum
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height:CGFloat = 0
        if indexPath.section == 0 {
            if model?.data?.banner?.count>0{
                
                height = 160
            }
        }else{
            
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
                height = 80
            }else if listModel?.widget_type?.integerValue == widgetType.RedPackage.rawValue {
                height = 80
            }

            
        }
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            if model?.data?.banner?.count>0{
                cell = CBRecommendADCellTableViewCell.createAdCellFor(tableView, atIndexPath: indexPath, withModel: model!)
            }
        }else{
            
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
                cell = CBRecommendLikeCell.createLikeCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            
            }else if listModel?.widget_type?.integerValue == widgetType.RedPackage.rawValue {
                cell = CBRedPacketCell.createRedPackageCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }

            
        }

        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headView :UIView? = nil
        if section>0{
            
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
                headView = CBSearchHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
            }

        }
        return headView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height:CGFloat = 0
        if section > 0 {
            
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
                height = 44
            }

        }
        
        return height
    }
    
    
}