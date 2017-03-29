//
//  WBHomeViewController.swift
//  WeiBo
//
//  Created by cp316 on 17/3/3.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class WBHomeViewController: WBBaseViewController {

    fileprivate lazy var statusLists = [String]()
    
    func showFriends() {
        let vc = WBFriendsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func loadData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
            for i in 0..<20 {
                if self.isPullup {
                    self.statusLists.append("上拉\(i)")
                    
                } else {
                    
                    self.statusLists.insert(i.description, at: 0)
                }
            }
            
            self.refreshControl?.endRefreshing()
            
            self.isPullup = false;
            
            self.tableView?.reloadData()
        }
    }
}

// MARK: - 表格数据源方法
extension WBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return statusLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = statusLists[indexPath.row]
        
        return cell
        
    }
}

extension WBHomeViewController {
    override func setupUI() {
        super.setupUI()
        
        // 设置导航条
        navItem.leftBarButtonItem = UIBarButtonItem(title:"好友", fontSize: 16, target: self, action: #selector(showFriends))
        
        // 注册原型cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}





