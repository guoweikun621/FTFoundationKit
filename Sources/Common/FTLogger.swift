//
//  FTLogger.swift
//  FTFoundationKit
//
//  Created by 郭伟坤 on 2016/10/20.
//  Copyright © 2016年 郭伟坤. All rights reserved.
//

import UIKit

public class FTLogger: NSObject {
    public class func log<T>(message: T, file: String = #file, method: String = #function, line: Int = #line) {
        #if DEBUG
            print("\((file as NSString).lastPathComponent) [\(line)], \(method): \(message)")
        #endif
    }
}
