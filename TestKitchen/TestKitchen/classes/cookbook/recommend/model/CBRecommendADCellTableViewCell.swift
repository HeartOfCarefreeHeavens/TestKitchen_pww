//
//  CBRecommendADCellTableViewCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBRecommendADCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    
    var bannerArray:Array<CBRecommendBannerModel>?{
    
        didSet{
            
            showData()
            
        }
    }
    
    func showData(){
        
        //0.添加容器视图
        let containerView = UIView.createView()
        scrollView.addSubview(containerView)
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            
            make.edges.equalTo(self!.scrollView)
            make.height.equalTo(self!.scrollView)
            
            
            
        }
        
        
        let cnt = bannerArray?.count
        
        if cnt > 0 {
            
            var lastView:UIView? = nil

            for i in 0..<cnt!{
                 //获取模型对象
                let model = bannerArray![i]
                //循环创建对象
                let tmpImageView = UIImageView.createImageView(nil)
                //progressBlock获取下载的进度
                //completionHandler:下载结束后的操作
                let url = NSURL(string: model.banner_picture!)
                let image = UIImage(named: "sdefaultImage")
                tmpImageView.kf_setImageWithURL(url, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                
                containerView.addSubview(tmpImageView)
                
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(kScreenWidth)
                    if i == 0{
                        make.left.equalTo(containerView)
                        
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                    
                })
                
                lastView = tmpImageView
            }

            containerView.snp_makeConstraints(closure: { (make) in
                
                make.right.equalTo(lastView!.snp_right)
                
            })
            
            pageCtrl.numberOfPages = cnt!
            scrollView.delegate = self
            scrollView.pagingEnabled = true
        }
        
        
    }
    
    
    //创建cell的方法
    class func createAdCellFor(tableView:UITableView,atIndexPath index:NSIndexPath,withModel model:CBRecommendModel)->CBRecommendADCellTableViewCell{
        
        let cellId = "recommendADCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendADCellTableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBRecommendADCellTableViewCell", owner: nil, options: nil).last as? CBRecommendADCellTableViewCell
        }
        
        cell?.bannerArray = model.data?.banner
        return cell!
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CBRecommendADCellTableViewCell:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        
        pageCtrl.currentPage = index
    }
    
}
