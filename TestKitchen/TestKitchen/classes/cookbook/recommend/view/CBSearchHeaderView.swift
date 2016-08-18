//
//  CBSearchHeaderView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CBSearchHeaderView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let searchBar = UISearchBar(frame: CGRectMake(0,0,bounds.size.width,bounds.size.height))
//        searchBar.placeholder = "输入菜名或食材搜索"
//        searchBar.alpha = 0.5
//        addSubview(searchBar)
        
        //用TextField创建searchBar
        let textField = UITextField(frame: CGRectMake(40,4,bounds.size.width-40*2,bounds.size.height-4*2))
        textField.borderStyle = .RoundedRect
        textField.placeholder = "输入菜名或食材搜索"
        addSubview(textField)
        
        //左边的搜索图片
        let imageView = UIImageView.createImageView("search1")
        imageView.frame = CGRectMake(0, 0, 30, 30)
        textField.leftView = imageView
        textField.leftViewMode = .Always
        
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
