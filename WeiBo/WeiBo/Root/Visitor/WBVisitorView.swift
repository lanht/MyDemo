//
//  WBVisitorView.swift
//  WeiBo
//
//  Created by Lanht on 17/4/7.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {
    
    var visitorInfo : [String : String]? {
        didSet {
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else {
                    return
            }
            
            tipLabel.text = message
            
            if imageName == "" {
                startAnimation()
                
                return
            }
            
            iconView.image = UIImage(named: imageName)
            
            houseIconView.isHidden = true
            maskIconView.isHidden = true

        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 首页旋转图标动画
    func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        anim.isRemovedOnCompletion = false
        
        iconView.layer.add(anim, forKey: nil)
    }
    // MARK: - 私有方法
    ///图像视图
    fileprivate lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    ///遮罩图像
    fileprivate lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    ///小房子
    fileprivate lazy var houseIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))

    ///提示标签
    fileprivate lazy var tipLabel: UILabel = UILabel.ht_label(text: "关注一些人，回这里看看有什么惊喜", fontSize: 14, textColor: UIColor.gray);
    
    ///注册按钮
    fileprivate lazy var registButton: UIButton = UIButton.ht_textButton(title: "注册", fontSize: 17, normalColor: UIColor.orange, heighlightColor: UIColor.black, backgroundImageName: "common_button_white")
    
    ///登录按钮
    fileprivate lazy var loginButton: UIButton = UIButton.ht_textButton(title: "登录", fontSize: 17, normalColor: UIColor.gray, heighlightColor: UIColor.black, backgroundImageName: "common_button_white")

}

extension WBVisitorView {
    fileprivate func setupUI() {
        backgroundColor = UIColor.white
        
        // 1,添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registButton)
        addSubview(loginButton)
        
        tipLabel.textAlignment = .center
        
        // 2,取消 autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 3,自动布局
        let margin: CGFloat = 20
        
        //>1 图像视图
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        
        //>2 小房子
        addConstraint(NSLayoutConstraint(item: houseIconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        //>3 提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: margin))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 230))
        
        //>4 注册按钮
        addConstraint(NSLayoutConstraint(item: registButton, attribute: .left, relatedBy: .equal, toItem: tipLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registButton, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: margin))
        addConstraint(NSLayoutConstraint(item: registButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        
        //>4 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: tipLabel, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
    }
}
