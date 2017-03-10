//
//  MyLabel.swift
//  重写set方法
//
//  Created by cp316 on 17/3/6.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class MyLabel: UILabel {

    var person: Person? {
        // *** 就是替代oc中 重写setter方法
        // 区别：再也不需要考虑 _成员变量 ＝ 值
        // OC 中如果是 copy 属性，应该 _成员变量 ＝ 值.copy
        didSet {
            text = person?.name
        }
    }
}
