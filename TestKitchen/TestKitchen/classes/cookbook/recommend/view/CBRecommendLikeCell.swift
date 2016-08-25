//
//  CBRecommendLikeCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBRecommendLikeCell: UITableViewCell {

    
    
    var model:CBRecommendWidgetListModel?{
        
        didSet{
            
            //显示图片和文字
           showData()
            
            
            
        }
        
    }
    
    func showData(){
        
        for var i in 0..<8{
            
            //每次遍历两个
            //图片
            if model?.widget_data?.count>i{
                let imageModel = model?.widget_data![i]
                if imageModel?.type == "image"{
                    //获取图片视图(按照tag值,xib中创建图片视图的时候设置了tag值)
                    let index = i/2
                    let subView = self.contentView.viewWithTag(200+index)
                    
                    if subView?.isKindOfClass(UIImageView.self) == true {
                        let imageView = subView as! UIImageView
                        let url = NSURL(string: (imageModel?.content)!)
                        imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdeafaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                        
                    }
                    
                    
                }
                
                
                //文字
                if model?.widget_data?.count>(i+1){
                    let textModel = model?.widget_data![i+1]
                    if textModel!.type == "text" {
                        let subView = self.contentView.viewWithTag(300+i/2)
                        if subView?.isKindOfClass(UILabel.self) == true {
                            let label = subView as! UILabel
                            label.text = textModel?.content
                        }
                    }
                }
                i += 1
            }
        }
        
        
    }
    
    //创建cell的方法
    class func createLikeCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath, withListModel listModel:CBRecommendWidgetListModel)->CBRecommendLikeCell{
        
            let cellId = "recommendLikeCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendLikeCell
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("CBRecommendLikeCell", owner: nil, options: nil).last as? CBRecommendLikeCell
            }
            
            cell?.model = listModel
            return cell!
        
    }
    
    @IBAction func clickBtn(sender: UIButton) {
        
        
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
