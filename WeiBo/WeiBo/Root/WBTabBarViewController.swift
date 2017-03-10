//
//  WBTabBarViewController.swift
//  WeiBo
//
//  Created by cp316 on 17/3/3.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class WBTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpChildViewControllers()
        
        for item in tabBar.items! as [UITabBarItem] {
            item.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 30)], for:UIControlState.normal)
            item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:UIControlState.normal)
            item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for:.normal)
        }
    }
}

extension WBTabBarViewController {
    
     func setUpChildViewControllers() {
        
        let array = [
            ["clsName":"WBHomeViewController","title":"首页","imageName":"tabbar_home"],
            ["clsName":"WBMassageViewController","title":"消息","imageName":"tabbar_message_center"],
            ["clsName":"WBDiscoverViewController","title":"发现","imageName":"tabbar_discover"],
            ["clsName":"WBUserCenterViewController","title":"我","imageName":"tabbar_profile"],
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM;
    }
    
    private func controller(dict:[String : String]) -> UIViewController {
        
        guard let clsName = dict["clsName"],
        let title = dict["title"],
        let imageName = dict["imageName"],
        let cls = NSClassFromString(Bundle.main.nameSpace() + "." + clsName) as? UIViewController.Type
        else {
            return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
        vc.tabBarItem.image = UIImage.init(named: imageName)
        vc.tabBarItem.selectedImage = UIImage.init(named: imageName + "_selected")

        let nav = WBNavigationController.init(rootViewController:vc);
        return nav;
    }
}
