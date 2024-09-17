//
//  User.swift
//  Navigation
//
//  Created by user on 22.08.2024.
//

import Foundation
import UIKit

class User {
    let login: String
    let avatar: UIImage?
    let fullName: String
    let status: String
    
    init(login: String, avatar: UIImage?, fullName: String, status: String) {
        self.login = login
        self.avatar = avatar
        self.fullName = fullName
        self.status = status
    }
}

protocol UserService {
    func signIn(login: String) -> User?
}

class CurrentUserService: UserService {
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func signIn(login: String) -> User? {
        if self.user.login == login {
            return self.user
        } else {
            return nil
        }
    }
    
    
}
        
    
    
    

    
    
    
    

