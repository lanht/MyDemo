//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by cp316 on 17/3/3.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    
    lazy var navItem = UINavigationItem();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
}

extension WBBaseViewController {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]
    }
}
