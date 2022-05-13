//
//  APIManager.swift
//
//  Created by Reshma on 19/04/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class APIManager {
    
    var manager: Session?
    static let sharedInstance: Session = {
        // work
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = API_CONSTANTS.REQUEST_TIMEOUT
        configuration.timeoutIntervalForResource = API_CONSTANTS.REQUEST_TIMEOUT
        configuration.httpAdditionalHeaders = Session.default.sessionConfiguration.httpAdditionalHeaders
        return Session(configuration: configuration)
    }()
    
    class func doRequest(_ strURL: String, method: Alamofire.HTTPMethod, params: Dictionary<String, Any>? = nil, allowSaveData: Bool? = false, success:@escaping (JSON) -> Void, failure:@escaping (JSON) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json"]
        sharedInstance.request(strURL, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            switch responseObject.result {
            case .success(let value):
                let resJson = JSON(value)
                print("Load from API: \n")
                print(resJson)
                success(resJson)
            case .failure(let error):
                let error: Error = error
                print("\nException Error: \(error.localizedDescription)")
            }
        }
    }
    
  
}
