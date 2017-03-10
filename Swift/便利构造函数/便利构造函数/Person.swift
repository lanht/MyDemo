//
//  Person.swift
//  便利构造函数
//
//  Created by cp316 on 17/3/8.
//  Copyright © 2017年 lanht. All rights reserved.
//

import UIKit

class Person: NSObject {

    var name: String?
    let age: Int = 0
    
    /**
     1,便利构造函数允许返回nil
       － 正常的构造函数一定会返回对象
       － 判断给定的参数是否符合条件，如果不符合条件，返回nil，不会创建对象，减少内存开销
     2，＊＊只有＊＊ 便利构造函数才会使用‘self.init’构造当前对象
       － 没有 convenience 关键字的构造函数是负责创建对象的，反之用来检查条件的，本身不负责对象的创建
     3，如果再便利构造函数中使用当前对象的属性，一定要在 self.init 之后
     */
    convenience init?(name: String, age: Int) {
        if age > 100 {
            return nil
        }
        self.init()
        self.name = name
    }
    
}
