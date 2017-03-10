//
//  ViewController.swift
//  重写set方法
//
//  Created by cp316 on 17/3/6.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p = Person()
        p.name = "xiaohua"
        
        let label = MyLabel(frame: CGRect(x: 20, y: 100, width: 100, height: 40))
        view.addSubview(label)
        
        label.person = p
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

