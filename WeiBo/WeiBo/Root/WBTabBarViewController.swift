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
        setUpComposeBtn()
        
    }
    
    @objc fileprivate func composeStatus() {
        print("撰写微博")
    }
    
    lazy var composeBtn: UIButton = {
        let btn = UIButton.init();
        btn.isUserInteractionEnabled = true
        btn.setImage(UIImage.init(named:"tabbar_compose_icon_add"), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        return btn
    }()
}

extension WBTabBarViewController {
    
    fileprivate func setUpComposeBtn() {
      
        tabBar.addSubview(composeBtn)
        
        let count = CGFloat((viewControllers?.count)!)
        let w = tabBar.bounds.width / count - 1
        
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        
        composeBtn.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
    }
    
    fileprivate func setUpChildViewControllers() {
        
        let array = [
            ["clsName":"WBHomeViewController","title":"首页","imageName":"tabbar_home","visitorInfo":["imageName":"","message":"关注一些人，回到这里看看有什么惊喜"]],
            
            ["clsName":"WBMassageViewController","title":"消息","imageName":"tabbar_message_center","visitorInfo":["imageName":"visitordiscover_image_message","message":"登录后，别人评论呢你的微博，给你发消息，都会在这里收到通知"]],
            
            ["clsName":"UIViewController"],
            
            ["clsName":"WBDiscoverViewController","title":"发现","imageName":"tabbar_discover","visitorInfo":["imageName":"visitordiscover_image_message","message":""]],
        ["clsName":"WBUserCenterViewController","title":"我","imageName":"tabbar_profile","visitorInfo":["imageName":"visitordiscover_image_profile","message":"登录后，你的微博、相册、个人资料会显示在这里，展示给别人"]],
        ]
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict as [String : AnyObject]))
        }
        viewControllers = arrayM;
        
        for item in tabBar.items! as [UITabBarItem] {
            item.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 30)], for:UIControlState.normal)
            item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:UIControlState.normal)
            item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for:.normal)
        }
    }
    
    private func controller(dict:[String : AnyObject]) -> UIViewController {
        
        guard let clsName = dict["clsName"] as? String,
        let title = dict["title"] as? String,
        let imageName = dict["imageName"] as? String,
        let cls = NSClassFromString(Bundle.main.nameSpace() + "." + clsName) as? WBBaseViewController.Type,
        let visitorInfo = dict["visitorInfo"] as? [String : String]
        else {
            return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
        vc.visitorInfo = visitorInfo
        vc.tabBarItem.image = UIImage.init(named: imageName)
        vc.tabBarItem.selectedImage = UIImage.init(named: imageName + "_selected")

        let nav = WBNavigationController.init(rootViewController:vc);
        return nav;
    }
}
