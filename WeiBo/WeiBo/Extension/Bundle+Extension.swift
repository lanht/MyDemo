//
//  Bundle+Extension.swift
//  WeiBo
//
//  Created by cp316 on 17/3/3.
//  Copyright © 2017年 lanht. All rights reserved.
//

import Foundation

extension Bundle {
    func nameSpace() -> String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
