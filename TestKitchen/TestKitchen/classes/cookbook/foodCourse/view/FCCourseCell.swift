//
//  FCCourseCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FCCourseCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var heightCon: NSLayoutConstraint!
    
    var model:FoodCourseSerialModel?{
        
        didSet{
            showData()
        }
    }
    
    
    func showData(){
        
        //标题
        nameLabel.text = model?.course_name
        //文字
        if model?.course_subject != nil {
            subjectLabel.text = model?.course_subject
            
            let dict = [NSFontAttributeName:UIFont.systemFontOfSize(17)]
            let h = NSString(string: (model?.course_subject)!).boundingRectWithSize(CGSizeMake(kScreenWidth-20*2, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: dict, context: nil).size.height
            //只要是有小数,整数部分就进位+1
            heightCon.constant = CGFloat(Int(h)+1)

        }
    }
    
    
    //计算cell的高度
    
    class func heightWithModel(model:FoodCourseSerialModel)->CGFloat{
        
        let titleH:CGFloat = 20
        let marginY:CGFloat = 10
        var height:CGFloat = marginY + titleH + marginY
        //计算subject文字高度
        let dict = [NSFontAttributeName:UIFont.systemFontOfSize(17)]
        if model.course_subject != nil {
            let h = NSString(string: model.course_subject!).boundingRectWithSize(CGSizeMake(kScreenWidth-20*2, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: dict, context: nil).size.height
            //只要是有小数,整数部分就进位+1
            let newH = CGFloat(Int(h)+1)
            height += (newH+marginY)
        }
        
        return height
        
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
