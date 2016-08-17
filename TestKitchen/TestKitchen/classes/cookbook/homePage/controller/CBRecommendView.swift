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
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if section == 0 {
            if model?.data?.banner?.count>0{
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
        }
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            if model?.data?.banner?.count>0{
                cell = CBRecommendADCellTableViewCell.createAdCellFor(tableView, atIndexPath: indexPath, withModel: model!)
            }
        }
        
        return cell
    }
    
    
    
}