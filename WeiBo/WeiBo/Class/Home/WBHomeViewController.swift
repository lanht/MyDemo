//
//  WBHomeViewController.swift
//  WeiBo
//
//  Created by cp316 on 17/3/3.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavItem()
    }
    
    func setUpNavItem() {
        navItem.leftBarButtonItem = UIBarButtonItem(title:"好友", fontSize: 16, target: self, action: #selector(showFriends))
    }
    
    func showFriends() {
        let vc = WBFriendsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
