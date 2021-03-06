//
//  KTCSegmentCtrl.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol KTCSegmentCtrlDelegate:NSObjectProtocol {
    func didSelectSegCtrl(segCtrl:KTCSegmentCtrl,atIndex index:Int)
}


class KTCSegmentCtrl: UIView {

    
    
    weak var delegate:KTCSegmentCtrlDelegate?
    
    //下划线视图
    private var lineView:UIView?
    //选中按钮的序号
    var selectIndex:Int = 0 {
        didSet{
            
            if selectIndex != oldValue{
                
                selectBtnAtIndex(selectIndex,lastIndex: oldValue)

            }
        }
    }
    
    //重新实现初始化方法
    /*
     titleNames:每个按钮上显示的文字
     
    */
     init(frame: CGRect,titleNames:[String]) {
        super.init(frame: frame)
        
        
        
        if titleNames.count>0{
            //按钮的宽度
            let w:CGFloat = bounds.size.width/CGFloat(titleNames.count)
            for i in 0..<titleNames.count{
                //计算按钮的frame
                let frame = CGRectMake(CGFloat(i)*w, 0, w, bounds.size.height)
                let btn = KTCSegmentBtn(frame: frame)
                btn.tag = 300 + i
                //显示数据
                btn.configTitle(titleNames[i])
                //点击事件
                btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
                
                //默认选中第一个
                if i == 0 {
                    btn.clicked = true
                }
                
                addSubview(btn)

            }
            //加下划线
            lineView = UIView.createView()
            lineView?.backgroundColor = UIColor.orangeColor()
            lineView?.frame = CGRectMake(0, bounds.size.height-2, w, 2)
            addSubview(lineView!)
        }
    }
    
    
    /*
     index:当前选中的序号
     lastIndex:上次选中的序号
     
     */
    func selectBtnAtIndex(index:Int,lastIndex:Int){
        
        //选中当前点击的按钮
        let curBtn = viewWithTag(300+index)
        if curBtn?.isKindOfClass(KTCSegmentBtn.self) == true {
            let btn = curBtn as! KTCSegmentBtn
            btn.clicked = true

        }
        
        //取消上次选中的按钮
        let lastBtn = viewWithTag(lastIndex + 300)
        if lastBtn!.isKindOfClass(KTCSegmentBtn.self) == true {
            let lastSegBtn = lastBtn as! KTCSegmentBtn
            lastSegBtn.clicked = false
        }
        
//        //修改当前选中的序号
//        selectIndex = index
        
        //修改下划线视图的位置
        lineView?.frame.origin.x = (lineView?.bounds.size.width)!*CGFloat(selectIndex)

        

    }
    
    func clickBtn(btn:KTCSegmentBtn){
        
        
        
        //如果点击的是已经选中的按钮
        if btn.tag != 300 + selectIndex {
            //修改UI
            selectIndex = btn.tag-300
            
            
            //其他操作
            delegate?.didSelectSegCtrl(self, atIndex: selectIndex)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class KTCSegmentBtn:UIControl{
    
    private var label:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //创建文字控件
        label = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(20), textAlignment: .Center, textColor: UIColor.grayColor())
        label?.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height-10)
        addSubview(label!)
        
    }

    var clicked:Bool?{
        
        didSet{
            if clicked == true {
                label?.textColor = UIColor.blackColor()
            }else if clicked == false{
                label?.textColor = UIColor.grayColor()
            }
        }
        
    }
    //显示数据
    func configTitle(title:String){
        
        label?.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}