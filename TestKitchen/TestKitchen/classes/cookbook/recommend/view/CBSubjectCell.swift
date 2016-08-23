//
//  CBSubjectCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBSubjectCell: UITableViewCell {

    @IBOutlet weak var subjectImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    
    var dataArray:Array<CBRecommendWidgetdataModel>?{
    
        didSet{
            showData()
        }
    }
    
    func showData(){
        //显示图片
        if dataArray?.count>0{
            let imageModel = dataArray![0]
            if imageModel.type == "image" {
                let url = NSURL(string: imageModel.content!)
                subjectImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        //描述标题
        if dataArray?.count>1{
            let titleModel = dataArray![1]
            if titleModel.type == "text" {
                titleLabel.text = titleModel.content
            }
            
        }
        
        //描述文字
        if dataArray?.count>2{
            let descModel = dataArray![2]
            if descModel.type == "text" {
                titleLabel.text = descModel.content
            }
            
        }

    }
    
    class func createSubjectCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendWidgetListModel)->CBSubjectCell{
        
        let cellId = "subjectCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBSubjectCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBSubjectCell", owner: nil, options: nil).last as? CBSubjectCell
        }
        
    
        if listModel.widget_data?.count>indexPath.row*3+2{
            //if 判断防止数组越界,其他地方同样
            let array = NSArray(array: listModel.widget_data!)
            cell?.dataArray = array.subarrayWithRange(NSMakeRange(indexPath.row*3, 3)) as? Array<CBRecommendWidgetdataModel>

        }
        
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
