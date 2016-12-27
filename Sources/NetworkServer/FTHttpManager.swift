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
    
    public func post() -> DataRequest {
        return request(method: .post)
    }
    
    public func get() -> DataRequest {
        return request(method: .get)
    }
    
    func request(method: Alamofire.HTTPMethod) -> DataRequest {
        let p = api.params
        let h = api.headers
        let req = defaultManager.request(api.url.absoluteString, method: method, parameters: p, encoding: URLEncoding.default, headers: h)
        return req
    }
    
    open func upload(complation: @escaping (_ result: SessionManager.MultipartFormDataEncodingResult) -> Void?) {
        if let uApi = api as? FTUploadApi {
            let files = uApi.filePaths

            defaultManager.upload(multipartFormData: { (formData) in
                var idx = 0
                files.forEach({ file in
                    formData.append(file, withName: "file\(idx)")
                    idx += 1
                })
            }, to: api.url, encodingCompletion: { (res) in
                switch res {
                case .success(let request, let streamingFromDisk, let streamFileURL):
                    complation(.success(request: request, streamingFromDisk: streamingFromDisk, streamFileURL: streamFileURL))
                case .failure(let eType):
                    complation(.failure(eType))
                }
            })
        }
        
    }
}


