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

protocol HttpManagerProtocol {
    var defaultManager: Alamofire.Manager { get }
    
}

public class FTHttpManager: NSObject, HttpManagerProtocol {
    
    var api: FTBasicApi
    
    init(api: FTBasicApi) {
        self.api = api
    }
    
    var defaultManager: Alamofire.Manager = {
        return Alamofire.Manager.sharedInstance
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
    
    func post() -> Alamofire.Request {
        return request(.POST)
    }
    
    func get() -> Alamofire.Request {
        return request(.GET)
    }
    
    func request(method: Alamofire.Method) -> Alamofire.Request {
        let p = api.params
        let h = api.headers
        let req = defaultManager.request(method, api.url.absoluteString!, parameters: p, encoding: .URLEncodedInURL, headers: h)
        return req
    }
    
    func upload(complation: (result: Manager.MultipartFormDataEncodingResult) -> Void?) {
        if let uApi = api as? FTUploadApi {
            let files = uApi.filePaths
            
            defaultManager.upload(.POST, api.url, multipartFormData: { formData in
                var idx = 0
                files.forEach({ file in
                    formData.appendBodyPart(fileURL: file, name: "file\(idx)")
                    idx += 1
                })
                }, encodingCompletion: { res in
                    switch res {
                    case .Success(let request, let streamingFromDisk, let streamFileURL):
                        complation(result: .Success(request: request, streamingFromDisk: streamingFromDisk, streamFileURL: streamFileURL))
                    case .Failure(let eType):
                        complation(result: .Failure(eType))
                    }
            })
        }
        
    }
}


