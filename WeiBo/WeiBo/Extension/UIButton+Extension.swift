//
//  UIButton+Extension.swift
//  WeiBo
//
//  Created by Lanht on 17/4/7.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

extension UIButton {
     class func ht_textButton(title:String,fontSize:CGFloat = 16.0,normalColor:UIColor,heighlightColor:UIColor,backgroundImageName:String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        btn.setTitleColor(normalColor, for: .normal)
        btn.setTitleColor(heighlightColor, for: .highlighted)
        btn.setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
        
        return btn
    }
}
