//
//  WBBaseViewController.swift
//  WeiBo
//
//  Created by cp316 on 17/3/3.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

// 注意：
// 1: extension 中不能有属性
// 2: extension 不能重写父类的方法。重写父类的方法，是子类的职责

class WBBaseViewController: UIViewController {

    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    
    lazy var navItem = UINavigationItem()
    
    var tableView : UITableView?
    
    var isPullup = false
    
    var userloginOn = false
    
    // 刷新控件
    var refreshControl : UIRefreshControl?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
    
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    // 加载数据 - 具体实现由子类负责
    func loadData() {
        // 如果子类不实现，默认关闭
        refreshControl?.endRefreshing();
    }
}

extension WBBaseViewController {
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        // 取消自动缩进 - 如果隐藏了导航栏会自动缩进20个点
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        userloginOn ? setupTableview() : setupVisitView()
    }
    
    private func setupNavigationBar() {
        
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]
    }
    
    private func setupTableview() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        //设置数据源&代理->目的：子类直接实现数据源方法
        tableView?.delegate = self
        tableView?.dataSource = self
        
        //设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom:tabBarController?.tabBar.bounds.height ?? 49, right: 0)
        
        // 设置刷新控件
        refreshControl = UIRefreshControl()
        tableView?.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    func setupVisitView() {
        let visitView = UIView(frame: view.bounds)
        visitView.backgroundColor = UIColor.red
        view.insertSubview(visitView, belowSubview: navigationBar)
        
    }
}

extension WBBaseViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    //基类只是准备方法，子类负责具体的实现
    //子类的数据源方法不需要super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //这里 return UITableViewCell()只是保证没有语法错误
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        let count = tableView.numberOfRows(inSection: section)
        
        /// 如果是最后一行，而且没有上拉刷新动作
        if row == (count - 1) && !isPullup{
            print("上拉刷新")
            isPullup = true
            
            loadData()
        }
    }
}





