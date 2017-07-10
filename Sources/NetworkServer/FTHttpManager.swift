//
//  FTHttpManager.swift
//  FTFoundationKit
//
//  Created by 郭伟坤 on 2016/10/12.
//  Copyright © 2016年 郭伟坤. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


open class FTHttpManager: NSObject {
    
    public var api: FTBasicApi
    
    public init(api: FTBasicApi) {
        self.api = api
    }
    
    open var defaultManager: Alamofire.SessionManager = {
        return Alamofire.SessionManager.default
    }()
    
//    var defaultManager: Alamofire.Manager = {
//        return Alamofire.Manager.sharedInstance
//        /**
//         let serverTrustPolicies: [String: ServerTrustPolicy] = [
//         BDURL.baseURL().absoluteString!: ServerTrustPolicy.PinCertificates(certificates: ServerTrustPolicy.certificatesInBundle(), validateCertificateChain: true, validateHost: true)
//         ]
//         
//         let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//         configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
//         
//         return Alamofire.Manager(
//         configuration: configuration,
//         serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//         ) */
//    }()
    
    open func post() -> DataRequest {
        return request(method: .post)
    }
    
    open func get() -> DataRequest {
        return request(method: .get)
    }
    
    func request(method: Alamofire.HTTPMethod) -> DataRequest {
        let p = api.params
        let h = api.headers
        let req = defaultManager.request(api.url.absoluteString, method: method, parameters: p, encoding: URLEncoding.default, headers: h)
        return req
    }
    
    open func uploadImageData(completion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        if let api = api as? FTUploadApi {
            let datas = api.fileDatas
            
            defaultManager.upload(multipartFormData: { (formData) in
                for (idx, data) in datas.enumerated() {
                    formData.append(data, withName: "file\(idx)")
                }
            }, to: api.url, encodingCompletion: completion)
        }
    }
    
    open func upload(complation: ((SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
        if let uApi = api as? FTUploadApi {
            let files = uApi.filePaths

            defaultManager.upload(multipartFormData: { (formData) in
                for (idx, file) in files.enumerated() {
                    formData.append(file, withName: "file\(idx)")
                }
            }, to: api.url, encodingCompletion: { (res) in
                complation?(res)
            })
        }
        
    }
}


