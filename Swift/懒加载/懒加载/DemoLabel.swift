//
//  DemoLabel.swift
//  懒加载
//
//  Created by cp316 on 17/3/6.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class DemoLabel: UILabel {

    var title: String?
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
