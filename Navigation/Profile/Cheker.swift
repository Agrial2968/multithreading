//
//  Cheker.swift
//  Navigation
//
//  Created by user on 05.09.2024.
//

import Foundation

final class Cheker {
    
    static let shared = Cheker()
    
    private let login = "agrial"
    private let password = "1234"
    
    func check(login: String, password: String) -> Bool {
        if login == self.login && password == self.password {
            return true
        }
        else {
            return false
        }
    }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
    
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Cheker.shared.check(login: login, password: password)
    }
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
