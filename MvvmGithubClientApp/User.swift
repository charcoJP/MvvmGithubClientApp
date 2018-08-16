//
//  User.swift
//  MvvmGithubClientApp
//
//  Created by user on 2018/08/15.
//  Copyright © 2018年 user. All rights reserved.
//

import Foundation

final class User {
    let id: Int
    let name: String
    let iconUrl: String
    let webUrl: String
    
    init(attributes: [String: Any]) {
        id = attributes["id"] as! Int
        name = attributes["login"] as! String
        iconUrl = attributes["avatar_url"] as! String
        webUrl = attributes["html_url"] as! String
    }
}

