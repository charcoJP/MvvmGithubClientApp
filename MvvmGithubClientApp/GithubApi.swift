//
//  GithubApi.swift
//  MvvmGithubClientApp
//
//  Created by user on 2018/08/15.
//  Copyright © 2018年 user. All rights reserved.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case unknown
    case invalidURL
    case invalidResponse
    
    var description: String {
        switch self {
        case .unknown: return "不明なエラーです"
        case .invalidURL: return "無効なURLです"
        case .invalidResponse: return "フォーマットが無効なレスポンスを受け取りました"
        }
    }
}

class GitHubApi {
    
    func getUsers(success: @escaping ([User]) -> Void,
                  failure: @escaping (Error) -> Void) {
        let requestUrl = URL(string: "https://api.github.com/users")
        guard let url = requestUrl else {
            failure(APIError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }
            
            guard
                let jsonOptional = try? JSONSerialization.jsonObject(with: data, options: []),
                let json = jsonOptional as? [[String: Any]]
                else {
                    DispatchQueue.main.async {
                        failure(APIError.invalidResponse)
                    }
                    return
            }
            
            var users = [User]()
            for j in json {
                let user = User(attributes: j)
                users.append(user)
            }
            DispatchQueue.main.async {
                success(users)
            }
        }
        task.resume()
    }
}

