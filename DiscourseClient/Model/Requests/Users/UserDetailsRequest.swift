//
//  UserDetailsRequest.swift
//  DiscourseClient
//
//  Created by Alberto García Antuña on 22/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct UserDetailsRequest: APIRequest {
    
    typealias Response = UserDetailsResponse
    
    let username: String
    
    init(username: String) {
        self.username = username
    }
        
    var method: Method {
        .GET
    }
    
    var path: String {
        return "/users/\(username).json"
    }
    
    var parameters: [String: String] {
        return [:]
    }
    
    var body: [String: Any] {
        return [:]
    }
    
    var headers: [String: String] {
        return [:]
    }
}
