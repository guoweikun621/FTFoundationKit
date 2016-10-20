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


@objc protocol FTHttpDelegate {
    optional func requestStart(manager: FTHttpManager)
    optional func requestDidSuccess(manager: FTHttpManager, result: [String: AnyObject]?)
    optional func requestDidFailure(manager: FTHttpManager, error: NSError)
}

public class FTHttpManager: NSObject {
    
    var api: FTBasicApi
    weak var delegate: FTHttpDelegate?
    
    
    init(api: FTBasicApi, delegate: FTHttpDelegate? = nil) {
        self.api = api
        self.delegate = delegate
    }
    
    let defaultManager: Alamofire.Manager = {
        return Alamofire.Manager.sharedInstance
        /**
         let serverTrustPolicies: [String: ServerTrustPolicy] = [
         BDURL.baseURL().absoluteString!: ServerTrustPolicy.PinCertificates(certificates: ServerTrustPolicy.certificatesInBundle(), validateCertificateChain: true, validateHost: true)
         ]
         
         let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
         configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
         
         return Alamofire.Manager(
         configuration: configuration,
         serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
         ) */
    }()
    
    func post() -> Alamofire.Request {
        return request(.POST)
    }
    
    func get() -> Alamofire.Request {
        return request(.GET)
    }
    
    func request(method: Alamofire.Method) -> Alamofire.Request {
        let p = api.params
        delegate?.requestStart?(self)
        let req = defaultManager.request(method, api.url.absoluteString!, parameters: p, encoding: .URLEncodedInURL, headers: nil)
//        req.responseJSON { resp in
//            self.disposeRequestResult(resp)
//        }
        return req
    }
    
    func upload(completion: (Manager.MultipartFormDataEncodingResult -> Void)?) {
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
                        debugPrint(request)
                        debugPrint(streamingFromDisk)
                        debugPrint(streamFileURL)
                    case .Failure:
                        debugPrint("")
                    }
            })
        }
        
    }
    
//    func disposeRequestResult(resp: Response<AnyObject, NSError>) -> Void {
//        let result = resp.result
//        if result.isSuccess {
//            let json = JSON(result.value!)
//            let code = json[HttpRespJsonKey.ResultCode].string ?? "0"
//            let msg = json[HttpRespJsonKey.ResultMsg].string ?? "未知错误"
//            if code == "000000" {
//                delegate?.requestDidSuccess?(self, result: json[HttpRespJsonKey.Data].dictionaryObject)
//            }
//            else {
//                let c = (code as NSString).integerValue
//                delegate?.requestDidFailure?(self, error: NSError(domain: "com.forte.error", code: c, userInfo: [NSLocalizedFailureReasonErrorKey: msg]))
//            }
//        }
//        else if result.isFailure {
//            let error = result.error ?? NSError(domain: "com.forte.error", code: 999, userInfo: [NSLocalizedFailureReasonErrorKey: "未知错误"])
//            delegate?.requestDidFailure?(self, error: error)
//        }
//    }
}


