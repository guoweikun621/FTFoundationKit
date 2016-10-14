//
//  FTAlamofireExtension.swift
//  FTFoundationKit
//
//  Created by 郭伟坤 on 2016/10/13.
//  Copyright © 2016年 郭伟坤. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension Alamofire.Request {
    
    func responseSwiftyJson(completion: (josn: JSON?, error: NSError?) ->Void) -> Alamofire.Request {
        self.responseJSON { response in
            let result = response.result
            if result.isFailure {
                let error = result.error
                completion(josn: nil, error: error)
            }
            else {
                let json = JSON(result.value!)
                completion(josn: json, error: nil)
            }
        }
        return self
    }
}
