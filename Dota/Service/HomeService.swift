//
//  HomeService.swift
//  Dota
//
//  Created by ilhamsaputra on 07/10/20.
//  Copyright © 2020 ilhamsaputra. All rights reserved.
//

import Foundation

class HomeService: BaseService {
    typealias ResponseType = [HeroModel]
    
    var url = ""
    
    func setUrl() -> URL {
        return URL(string: url)!
    }
    
    func method() -> BaseNetwork.Method {
        return .get
    }
    
    func timeout() -> TimeInterval {
        return 30
    }
}
