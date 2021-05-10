//
//  GetCategoriesRequest.swift
//  DiscourseClient
//
//  Created by Alberto García Antuña on 17/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct GetCategoriesRequest: APIRequest{
    
    typealias Response = CategoriesResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/categories.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}
