//
//  UserListViewModel.swift
//  MvvmGithubClientApp
//
//  Created by user on 2018/08/16.
//  Copyright © 2018年 user. All rights reserved.
//

import Foundation
import UIKit

enum ViewModelState {
    case loading
    case finish
    case error(Error)
}

final class UserListViewModel {
    
    var stateDidUpdate: ((ViewModelState) -> Void)?
    
    private var users = [User]()
    
    var cellViewModels = [UserCellViewModel]()
    
    let githubApi = GitHubApi()
    
    func getUsers() {
        // loading通知を送る
        stateDidUpdate?(.loading)
        
        users.removeAll()
        
        githubApi.getUsers(success: { (users) in
            self.users.append(contentsOf:users)
            for user in users {
                let cellViewModel = UserCellViewModel(user: user)
                self.cellViewModels.append(cellViewModel)
                
                // 通信完了通知
                self.stateDidUpdate?(.finish)
            }
        }) { (error) in
            self.stateDidUpdate?(.error(error))
        }
    }
    
    func usersCount() -> Int {
        return users.count
    }
}
