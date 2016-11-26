//
//  FTBasicApi.swift
//  FTFoundationKit
//
//  Created by 郭伟坤 on 2016/10/13.
//  Copyright © 2016年 郭伟坤. All rights reserved.
//

import UIKit

@objc public protocol FTHttpApiProtocol {
    var url: NSURL {get}
    
    var params: [String: AnyObject]? { get }
    var headers: [String: String]? { get }
    
    var path: String { get }
    
    
    optional func addParams() -> [String: AnyObject]?
    optional func addHeaders() -> [String: String]?
}


public class FTBasicApi: NSObject, FTHttpApiProtocol {
    public var url: NSURL {
        get {
            return NSURL()// BDURL.baseURL().URLByAppendingPathComponent(path)!
        }
    }
    
    public var path: String {
        return ""
    }
    
    
    public var params: [String: AnyObject]? {
        get {
            if let p = self.addParams() {
                return p
            }
            
            return nil
        }
    }
    
    public var headers: [String: String]? {
        get {
            if let h = self.addHeaders() {
                return h
            }
            return nil
        }
    }
    
    
    @objc public func addParams() -> [String : AnyObject]? {
        return nil
    }
    
    @objc public func addHeaders() -> [String : String]? {
        return nil
    }

}

public class FTUploadApi: FTBasicApi {
    var filePaths = [NSURL]()
    
}
