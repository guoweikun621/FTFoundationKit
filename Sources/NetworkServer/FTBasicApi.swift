//
//  FTBasicApi.swift
//  FTFoundationKit
//
//  Created by 郭伟坤 on 2016/10/13.
//  Copyright © 2016年 郭伟坤. All rights reserved.
//

import UIKit

@objc public protocol FTHttpApiProtocol {
    var url: URL {get}
    
    var params: [String: Any]? { get }
    var headers: [String: String]? { get }
    
    var path: String { get }
    
    
    @objc optional func addParams() -> [String: Any]?
    @objc optional func addHeaders() -> [String: String]?
}


open class FTBasicApi: NSObject, FTHttpApiProtocol {
    open var url: URL {
        get {
            return URL(string: "")!// BDURL.baseURL().URLByAppendingPathComponent(path)!
        }
    }
    
    open var path: String {
        return ""
    }
    
    
    public var params: [String: Any]? {
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
    
    
    @objc open func addParams() -> [String : Any]? {
        return nil
    }
    
    @objc open func addHeaders() -> [String : String]? {
        return nil
    }

}

open class FTUploadApi: FTBasicApi {
    open var filePaths = [URL]()
    
}
