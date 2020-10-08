//
//  BaseService.swift
//  Dota
//
//  Created by ilhamsaputra on 06/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseService {
    associatedtype ResponseType: Codable
    
    func method() -> BaseNetwork.Method
    func setUrl() -> URL
    func timeout() -> TimeInterval
}

enum NetworkResult<T> {
    case success(T)
    case failure(String)
}

class BaseNetwork {
    public enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    @discardableResult
    static func request<T: BaseService>(req: T, completionHandler: @escaping (NetworkResult<T.ResponseType>) -> Void) -> DataRequest? {
        
        let url = req.setUrl()
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: req.timeout())
        request.httpMethod = req.method().rawValue
        
        return AF.request(request).responseJSON { (response) in
            
            if let err = response.error {
                completionHandler(NetworkResult.failure(err.localizedDescription))
                return
            }
        
            if let responseCode = response.response {
                switch responseCode.statusCode {
                case 200:
                    if let data = response.data {
                        let decoder = JSONDecoder()
                        do {
                            let object = try decoder.decode(T.ResponseType.self, from: data)
                            completionHandler(NetworkResult.success(object))
                        } catch let error {
                            completionHandler(NetworkResult.failure(error.localizedDescription))
                        }
                    }
                default:
                    completionHandler(NetworkResult.failure(Constant.FAILED_REQUEST))
                }
            }
        }
    }
}
