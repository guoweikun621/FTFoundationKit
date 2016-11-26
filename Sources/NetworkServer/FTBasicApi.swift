//
//  FTBasicApi.swift
//  FTFoundationKit
//
//  Created by 郭伟坤 on 2016/10/13.
//  Copyright © 2016年 郭伟坤. All rights reserved.
//

import UIKit


@objc protocol HttpApiProtocol {
    var url: NSURL {get}
    
    var params: [String: AnyObject]? { get }
    var headers: [String: String]? { get }
    
    var path: NSString { get set }
    
    
    optional func addParams() -> [String: AnyObject]?
    optional func addHeaders() -> [String: String]?
    
}


public class FTBasicApi: NSObject {
    var url: NSURL {
        get {
            return NSURL()// BDURL.baseURL().URLByAppendingPathComponent(path)!
        }
    }
    
    var path: String = ""
    
    
    var params: [String: AnyObject]? {
        get {
            if let p = self.addParams() {
                return p
            }
            
            return nil
        }
    }
    
    var headers: [String: String]? {
        get {
            if let h = self.addHeaders() {
                return h
            }
            return nil
        }
    }
    
    
    func addParams() -> [String : AnyObject]? {
        return nil
    }
    
    func addHeaders() -> [String : String]? {
        return nil
    }

}

public class FTUploadApi: FTBasicApi {
    var filePaths = [NSURL]()
    
}
