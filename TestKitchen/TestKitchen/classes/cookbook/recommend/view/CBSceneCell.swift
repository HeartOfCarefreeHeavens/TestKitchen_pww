//
//  CBSceneCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBSceneCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    
    //显示数据
    func configTitle(title:String){
        
        self.nameLabel.text = title
    }
    
    
    //创建cell的方法
    class func createSceneCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendWidgetListModel)->CBSceneCell{
        
        let cellId = "sceneCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBSceneCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBSceneCell", owner: nil, options: nil).last as? CBSceneCell
        }
    
        if let title = listModel.title{
            cell?.configTitle(title)
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
