//
//  CBRedPacketCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBRedPacketCell: UITableViewCell {

    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //显示数据
    var model:CBRecommendWidgetListModel?{
        
        didSet{
            
            
            showData()
            
        }
        
    }
    
    //显示文字图片
    func showData(){
        
        //1.容器视图
        let containerView = UIView.createView()
        scrollView.addSubview(containerView)
        
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView)
            make.height.equalTo(self!.scrollView.snp_height)
        }
        
        var lastView:UIView? = nil
        let cnt = model?.widget_data?.count
        if cnt > 0 {
            for i in 0..<cnt!{
                
                let imageModel = model?.widget_data![i]
                
                //显示在线图片
                if imageModel?.type == "image" {
                    let imageView = UIImageView.createImageView(nil)
                    let url = NSURL(string: (imageModel?.content)!)
                    imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named:"sdeafaultImage" ), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    containerView.addSubview(imageView)
                    
                    //约束
                    imageView.snp_makeConstraints(closure: { (make) in
                        
                        make.top.bottom.equalTo(containerView)
                        make.width.equalTo(180)
                        if i == 0{
                            make.left.equalTo(0)
                        }else{
                            make.left.equalTo(lastView!.snp_right)
                        }
                        
                    })
                    //添加点击事件
                    imageView.userInteractionEnabled = true
                    imageView.tag = 400 + i
                    let g = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
                    imageView.addGestureRecognizer(g)
                    
                    lastView = imageView

                }
                    
                containerView.snp_makeConstraints(closure: { (make) in
                    
                    make.right.equalTo((lastView?.snp_right)!)
                    
                })
            }
            
            

        }
        
    }
    
    func tapAction(g:UIGestureRecognizer){
        let index = (g.view?.tag)! - 400
        print(index)
    }
    
    class func createRedPackageCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendWidgetListModel)->CBRedPacketCell{
        
        let cellId = "redPacketCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRedPacketCell
        if cell == nil {
            
            cell = NSBundle.mainBundle().loadNibNamed("CBRedPacketCell", owner: nil, options: nil).last as? CBRedPacketCell
        }
        
        cell?.model = listModel
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




