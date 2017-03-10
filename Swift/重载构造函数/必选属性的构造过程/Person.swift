//
//  Person.swift
//  必选属性的构造过程
//
//  Created by cp316 on 17/3/6.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit
/**
  1,给自己的属性分配空间并且设置初始值
  2,调用父类构造函数，给父类属性分配空间设置初始值
    NSObject没有属性，只有一个成员变量‘isa’
 */
class Person: NSObject {

    var name: String
//    override init() {
//        
//        name = "zhang"
//        
//        super.init()
//    }
    
    // '重载' 函数名相同，但是参数和个数不同
    // 如果重载了构造函数，并且实现了init方法，系统就不再提供init（）构造函数，因为默认的构造函数，不能给本类的属性分配空间
    init(name: String ) {
        self.name = name
        super.init()
    }
}
