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

//extension CBRecommendView:UITableViewDelegate,UITableViewDataSource{
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        //广告数据显示一个分组
//        var sectionNum = 1
//        if model?.data?.widgetList?.count>0{
//            
//            sectionNum += (model?.data?.widgetList?.count)!
// 
//        }
//        return sectionNum
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var rowNum = 0
//        if section == 0 {
//            if model?.data?.banner?.count>0{
//                rowNum = 1
//            }
//        }else{
//            let listModel = model?.data?.widgetList![section-1]
//            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue {
//                rowNum = 1
//            }else if listModel?.widget_type?.integerValue == widgetType.RedPackage.rawValue {
//                rowNum = 1
//            }else if listModel?.widget_type?.integerValue == widgetType.NewProduct.rawValue{
//                rowNum = 1
//            }
//
//        }
//        return rowNum
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        var height:CGFloat = 0
//        if indexPath.section == 0 {
//            if model?.data?.banner?.count>0{
//                
//                height = 160
//            }
//        }else{
//            
//            let listModel = model?.data?.widgetList![indexPath.section-1]
//            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
//                height = 80
//            }else if listModel?.widget_type?.integerValue == widgetType.RedPackage.rawValue {
//                height = 100
//            }else if listModel?.widget_type?.integerValue == widgetType.NewProduct.rawValue{
//                height = 300
//            }
//
//
//            
//        }
//        return height
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        var cell = UITableViewCell()
//        if indexPath.section == 0 {
//            if model?.data?.banner?.count>0{
//                cell = CBRecommendADCellTableViewCell.createAdCellFor(tableView, atIndexPath: indexPath, withModel: model!)
//            }
//        }else{
//            
//            let listModel = model?.data?.widgetList![indexPath.section-1]
//            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
//                cell = CBRecommendLikeCell.createLikeCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
//            
//            }else if listModel?.widget_type?.integerValue == widgetType.RedPackage.rawValue {
//                cell = CBRedPacketCell.createRedPackageCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
//            }else if listModel?.widget_type?.integerValue == widgetType.NewProduct.rawValue {
//                cell = CBRecommendNewCell.createNewCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
//            }
//
//
//            
//        }
//
//        
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        var headView :UIView? = nil
//        if section>0{
//            
//            let listModel = model?.data?.widgetList![section-1]
//            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
//                headView = CBSearchHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
//            }else if listModel?.widget_type?.integerValue == widgetType.NewProduct.rawValue{
//                let tmpView = CBHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
//                tmpView.configTitle((listModel?.title)!)
//                headView = tmpView
//            }
//
//
//        }
//        return headView
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//        var height:CGFloat = 0
//        if section > 0 {
//            
//            let listModel = model?.data?.widgetList![section-1]
//            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue||listModel?.widget_type?.integerValue == widgetType.NewProduct.rawValue{
//                height = 44
//            }
//
//        }
//        
//        return height
//    }
//    
//    
//}

extension CBRecommendView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //广告数据显示一个分组
        var sectionNum = 1
        
        if model?.data?.widgetList?.count > 0 {
            sectionNum += (model?.data?.widgetList?.count)!
        }
        
        return sectionNum
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowNum = 0
        
        if section == 0 {
            //广告的数据
            if model?.data?.banner?.count > 0 {
                rowNum = 1
            }
        }else{
            
            //其他的情况
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue {
                //猜你喜欢
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == widgetType.RedPackage.rawValue {
                //红包入口
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == widgetType.NewProduct.rawValue {
                //今日新品
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == widgetType.Special.rawValue {
                //早餐日记,健康100岁
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == widgetType.Scene.rawValue {
                //全部场景
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == widgetType.Talent.rawValue {
                //推荐达人
                rowNum = (listModel?.widget_data?.count)!/4
            }else if listModel?.widget_type?.integerValue == widgetType.Works.rawValue {
                //精选作品
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == widgetType.Subject.rawValue {
                //专题
                rowNum = (listModel?.widget_data?.count)!/3
            }




            
        }
        
        return rowNum
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height: CGFloat = 0
        
        if indexPath.section == 0 {
            //广告的高度
            if model?.data?.banner?.count > 0 {
                height = 160
            }
        }else{
            
            //其他情况
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue {
                //猜你喜欢
                height = 80
            }else if listModel?.widget_type?.integerValue == widgetType.RedPackage.rawValue {
                //红包入口
                height = 100
            }else if listModel?.widget_type?.integerValue == widgetType.NewProduct.rawValue {
                //今日新品
                height = 300
            }else if listModel?.widget_type?.integerValue == widgetType.Special.rawValue {
                //早餐日记,健康100岁
                height = 200
            }else if listModel?.widget_type?.integerValue == widgetType.Scene.rawValue {
                //全部场景
                height = 60
            }else if listModel?.widget_type?.integerValue == widgetType.Talent.rawValue {
                //推荐达人
                height = 80
            }else if listModel?.widget_type?.integerValue == widgetType.Works.rawValue {
                //精选作品
                height = 240
            }else if listModel?.widget_type?.integerValue == widgetType.Subject.rawValue {
                //专题
                height = 180
            }





            
        }
        
        
        return height
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            //广告
            if model?.data?.banner?.count > 0 {
                cell = CBRecommendADCellTableViewCell.createAdCellFor(tableView, atIndexPath: indexPath, withModel: model!)
            }
        }else{
            
            //其他情况
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue {
                //猜你喜欢
                cell = CBRecommendLikeCell.createLikeCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == widgetType.RedPackage.rawValue {
                //红包入口
                cell = CBRedPacketCell.createRedPackageCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == widgetType.NewProduct.rawValue {
                //今日新品
                cell = CBRecommendNewCell.createNewCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
                //早餐日记,健康100岁
            }else if listModel?.widget_type?.integerValue == widgetType.Special.rawValue{
                cell = CBSpecialCell.createSpecialCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue == widgetType.Scene.rawValue{
                //全部场景
                cell = CBSceneCell.createSceneCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue ==
                widgetType.Talent.rawValue{
                //推荐达人
                cell = CBTalentCell.createTalentCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue ==
                widgetType.Works.rawValue{
                //精选作品
                cell = CBWorksCell.createWorksCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }else if listModel?.widget_type?.integerValue ==
                widgetType.Subject.rawValue{
                //专题
                cell = CBSubjectCell.createSubjectCellFor(tableView, atIndexPath: indexPath, withListModel: listModel!)
            }

        }
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headView: UIView? = nil
        if section > 0 {
            //其他情况
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue {
                //猜你喜欢
                headView = CBSearchHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
            }else if listModel?.widget_type?.integerValue == widgetType.NewProduct.rawValue || listModel?.widget_type?.integerValue == widgetType.Special.rawValue || listModel?.widget_type?.integerValue == widgetType.Talent.rawValue || listModel?.widget_type?.integerValue == widgetType.Works.rawValue || listModel?.widget_type?.integerValue == widgetType.Subject.rawValue{
                //今日新品
                //早餐日记
                //推荐达人
                //精选作品
                //专题
                let tmpView = CBHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
                tmpView.configTitle((listModel?.title)!)
                headView = tmpView
            }
        }
        
        return headView
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height: CGFloat = 0
        if section > 0 {
            //其他情况
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue || listModel?.widget_type?.integerValue == widgetType.NewProduct.rawValue || listModel?.widget_type?.integerValue == widgetType.Special.rawValue || listModel?.widget_type?.integerValue == widgetType.Talent.rawValue || listModel?.widget_type?.integerValue == widgetType.Works.rawValue || listModel?.widget_type?.integerValue == widgetType.Subject.rawValue{
                //猜你喜欢 -- GuessYourLike
                //今日新品 -- NewProduct
                //早餐日记.健康100岁 -- Special
                //推荐达人
                //精选作品
                //专题
                height = 44
            }
        }
        
        return height
    }
    
    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let h:CGFloat = 44
//        if scrollView.contentOffset.y<h{
//            scrollView.contentInset = UIEdgeInsetsMake(h, 0, 0, 0)
//        }else if scrollView.contentOffset.y>0{
//            scrollView.contentInset = UIEdgeInsetsMake(0, 0, -scrollView.contentOffset.y, 0)
//            
//        }
        
//    }
    
    
}


