 //
//  ViewController.swift
//  懒加载
//
//  Created by cp316 on 17/3/6.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 简单写法
    lazy var label: DemoLabel = DemoLabel()

    // 完整写法 日常开发中用上面简写法
    lazy var label2: DemoLabel = { ()->DemoLabel in
        let l = DemoLabel()
        return l
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(label)
        
        
    }

}

