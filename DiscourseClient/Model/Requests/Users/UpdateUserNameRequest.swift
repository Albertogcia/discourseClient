//
//  UpdateUserNameRequest.swift
//  DiscourseClient
//
//  Created by Alberto García Antuña on 23/01/2021.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct UpdateUserNameRequest: APIRequest {
    
    typealias Response = UserNameUpdateResponse
    
    let username: String
    let newName: String
    
    init(username: String, newName: String) {
        self.username = username
        self.newName = newName
    }
        
    var method: Method {
        .PUT
    }
    
    var path: String {
        return "/users/\(username).json"
    }
    
    var parameters: [String: String] {
        return [:]
    }
    
    var body: [String: Any] {
        return ["name": newName]
    }
    
    var headers: [String: String] {
        return [:]
    }
}
