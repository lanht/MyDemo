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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showFriends))
    }
    
    func showFriends() {
        let vc = WBFriendsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
