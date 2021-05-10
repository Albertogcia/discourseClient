//
//  AllUsersRequest.swift
//  DiscourseClient
//
//  Created by Alberto García Antuña on 18/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct AllUsersRequest: APIRequest{
    
    typealias Response = UsersResponse
        
    var method: Method {
        .GET
    }
    
    var path: String {
        return "/directory_items.json"
    }
    
    var parameters: [String : String] {
        return ["period":"all","order":"post_count"]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
