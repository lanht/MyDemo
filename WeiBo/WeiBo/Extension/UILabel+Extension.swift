//
//  UILabel+Extension.swift
//  WeiBo
//
//  Created by Lanht on 17/4/7.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

extension UILabel {
    class func ht_label(text: String,fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        label.textColor = textColor
        
        return label
    }
}
