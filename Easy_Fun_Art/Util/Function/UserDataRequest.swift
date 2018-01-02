//
//  UserDataRequest.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 2..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

struct UserDataRequest: GraphRequestProtocol {
    public let graphPath = "me"
    public let parameters: [String:Any]? = ["fields" : "id, email, name, picture{url}"]
    public let accessToken: AccessToken? = AccessToken.current
    public let httpMethod: GraphRequestHTTPMethod = .GET
    public let apiVersion: GraphAPIVersion = GraphAPIVersion.defaultVersion
    
    struct Response: GraphResponseProtocol {
        var id = ""
        var email = ""
        var name = ""
        var profileURL = ""
        
        init(rawResponse: Any?) {
            if let data = rawResponse as? [String:Any] {
                if let id = data["id"] {
                    self.id = id as! String
                }
                if let email = data["email"] {
                    self.email = email as! String
                }
                if let name = data["name"] {
                    self.name = name as! String
                }
                if let profileURL = (data["picture"] as? [String: [String:String]])?["data"]?["url"] {
                    self.profileURL = profileURL
                }
            }
        }
    }
}

