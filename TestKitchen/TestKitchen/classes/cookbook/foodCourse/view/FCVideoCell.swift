//
//  FCVideoCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/25.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FCVideoCell: UITableViewCell {

    //视频播放(闭包传值)
    var videoClosure:(String->Void)?
    
    var model:FoodCourseSerialModel?{
        
        didSet{
            if model != nil {
                showData()
 
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    //播放视频
    @IBAction func playVideo(sender: UIButton) {
        
        self.videoClosure!((model?.course_video)!)
        
    }
    
    func showData(){
        
        //图片
        let url = NSURL(string: (model?.course_image)!)
        self.bgImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        //文字
        
        if model?.video_watchcount != nil {
            titleLabel.text = String(format: "%@人做过", (model?.video_watchcount)!)

        }

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
