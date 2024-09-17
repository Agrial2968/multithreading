//
//  TestUserService.swift
//  Navigation
//
//  Created by user on 29.08.2024.
//

import Foundation
import UIKit

class TestUserService: UserService {

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
    
    


