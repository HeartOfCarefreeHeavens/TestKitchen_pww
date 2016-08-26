//
//  FCSerialCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/26.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol FCSerialCellDelegate:NSObjectProtocol {
    //选中第几集
    func didSelectSerialAtIndex(index:Int)
    /**修改展开和收起的状态*/
    func changeExpandState(isExpand:Bool)
    
}

class FCSerialCell: UITableViewCell {
    //代理属性
    weak var delegate:FCSerialCellDelegate?
    
    //更多->按钮
    private var moreBtn:UIButton?
    
    //当前集数是展开还是合起
    var isExpand:Bool = false
    
    //选中按钮的序号
    var selectIndex:Int = 0{
        didSet{
            selectBtnAtIndex(selectIndex, lastIndex: oldValue)
        }
    }
    
    
    /*一共多少集*/
    var num:Int?{
        
        didSet{
            if num>0{
                showData()
            }
        }
    }
    
    //按钮宽度
    private var btnW:CGFloat{
        get{
            return 40
        }
    }
    
    //最左边和最右边的间距
    private var margin:CGFloat{
        get{
            return 20
        }
    }
    
    //按钮高度
    private var btnH:CGFloat{
        get{
            return 40
        }
    }
    
    //纵向间距
    private var spaceY:CGFloat{
        get{
            return 10
        }
    }
    
    //每一行有多少按钮
    private var rowNum:Int{
        get{
            return Int((kScreenWidth - margin*2)/btnW)
        }
    }
    
     //横向间距
    private var spaceX:CGFloat{
        get{
            return (kScreenWidth-margin*2-CGFloat(rowNum)*btnW)/CGFloat(rowNum-1)
        }
    }
    
    //更多按钮的宽度
    private var moreBtnW:CGFloat{
        get{
            return 40
        }
    }


    private var moreBtnH:CGFloat{
        get{
            return 30
        }
    }

    
    
    
    func showData(){
        
        //删除之前的子视图
        for oldSub in contentView.subviews {
            oldSub.removeFromSuperview()
        }
        
        //计算当前应该显示多少个
        var cnt = num!
        if num! > rowNum*2{
            //超过两行,要判断是否展开
            if isExpand == false{
                //如果没有展开
                cnt = rowNum*2
            }
        }
        
        for i in 0..<cnt{
            //计算行号和列号
            let row = i/rowNum
            let col = i%rowNum
            let frame = CGRectMake(margin+CGFloat(col)*(btnW+spaceX), spaceY+CGFloat(row)*(btnH+spaceY),btnW, btnH)
            
            let btn = FCSerialBtn(frame: frame, index: i+1)
            btn.tag = 500 + i
            btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents:.TouchUpInside )
            
            contentView.addSubview(btn)
            
        }
        
        //判断是否展开按钮
        if num>rowNum*2{
            
            var imageName = "pull.png"
            var btnRow = 2
            if isExpand == true {
                imageName = "push.png"
                //计算最大行数
                btnRow = num!/rowNum
                if num! % rowNum > 0 {
                    btnRow += 1
                }
            }
            
            moreBtn = UIButton.createBtn(nil, bgImageName: imageName, selectBgImageName: nil, target: self , action: #selector(expandAction))
            moreBtn?.frame = CGRectMake((kScreenWidth-moreBtnW*2)/2, margin+(btnH+spaceY)*CGFloat(btnRow), moreBtnW, moreBtnH)
            contentView.addSubview(moreBtn!)
        }
        
    }
    
    func expandAction(){
        
        //修改展开和收起的状态
        delegate?.changeExpandState(!isExpand)
        
    }
    
    
    //点击按钮时修改UI
    func selectBtnAtIndex(index:Int, lastIndex:Int){
        
        //取消选中之前的按钮
        let lastBtn = contentView.viewWithTag(500+lastIndex)
        if lastBtn?.isKindOfClass(FCSerialBtn.self) == true{
            let btn = lastBtn as! FCSerialBtn
            btn.clicked = false
        }
        
        //当前选中的按钮
        let curBtn = contentView.viewWithTag(500+index)
        if curBtn?.isKindOfClass(FCSerialBtn.self) == true{
            let btn = curBtn as! FCSerialBtn
            btn.clicked = true
        }
        
    }
    
    
    func clickBtn(btn:FCSerialBtn){
        
        //修改当前cell的UI
        selectIndex = btn.tag-500
        //其他的操作
        delegate?.didSelectSerialAtIndex(selectIndex)
        
        
        
        
    }
    
    
    //计算cell的高度
    /*
     参数:
     num:一共多少集
     isExpand:是否展开
     */
    
    class func heightWithNum(num:Int,isExpand:Bool)->CGFloat{
        
        let cell = FCSerialCell()
        
        //一共有几行
        var rows = num/cell.rowNum
        if num%cell.rowNum>0{
            rows += 1
        }
        
        //如果num大于两行并且是合起的状态
        if (num>cell.rowNum*2) && (isExpand == false){
            rows = 2
        }
        
        var h = cell.margin + CGFloat(rows)*(cell.btnH+cell.spaceY)
        
        if num>cell.rowNum*2{
            h += (cell.moreBtnH + cell.margin)
        }
        return h
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


//自定制每一集的按钮
class FCSerialBtn:UIControl{
    
    var titleLabel:UILabel?
    
    var clicked:Bool?{
     
        didSet{
            if clicked == true{
                //选中
                backgroundColor = UIColor.orangeColor()
                titleLabel?.textColor = UIColor.whiteColor()
            }else if clicked == false{
                backgroundColor = UIColor(white: 0.8, alpha: 1.0)
                titleLabel?.textColor = UIColor.grayColor()
            }

        }
        
    }
    
    init(frame: CGRect,index:Int) {
        super.init(frame: frame)
        titleLabel = UILabel.createLabel("\(index)", font: UIFont.systemFontOfSize(12), textAlignment: .Center, textColor: UIColor.grayColor())
        titleLabel?.frame = bounds
        addSubview(titleLabel!)
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
