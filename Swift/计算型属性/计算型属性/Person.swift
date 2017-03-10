//
//  Person.swift
//  计算型属性
//
//  Created by cp316 on 17/3/6.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class Person: NSObject {
 
    // getter & setter 仅供演示 日常开发中不用
    private var _name: String?
    
    // Swift 中 一般不会重写 getter 方法和 setter方法
    var name: String? {
        get {
            
            return _name

        }
        set {

            _name = newValue
        }
    }
    
    // OC  中定义属性的时候，有一个readonly ——>对应 swift中只重写getter方法
    // 就是只读属性
    var title: String? {
        get {
            return "Mr.xxx"
        }
    }
    
    // 只读属性的简写 直接return
    var title2: String? {
        return "Mr." + (_name ?? "")
    }
}
