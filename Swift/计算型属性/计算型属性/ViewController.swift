//
//  ViewController.swift
//  计算型属性
//
//  Created by cp316 on 17/3/6.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p = Person()
        
        p.name = "laowang"
        
        print(p.name ?? "")
        
        print(p.title2 ?? "")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

