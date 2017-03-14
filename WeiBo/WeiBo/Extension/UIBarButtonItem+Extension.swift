//
//  UIBarButtonItem+Extension.swift
//  WeiBo
//
//  Created by cp316 on 17/3/14.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(title:String,fontSize:CGFloat = 16.0,target:AnyObject,action:Selector, isBack : Bool = false) {
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.setTitleColor(.orange, for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        if isBack {
            let imageName = "navigationbar_back_withtext"
            btn.setImage(UIImage(named:imageName), for: .normal)
            btn.setImage(UIImage(named:imageName + "_highlighted"), for:.highlighted)

        }
        btn.sizeToFit()

        self.init(customView:btn)
    }
}
