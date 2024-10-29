//
//  NetworkManager.swift
//  Navigation
//
//  Created by user on 29.10.2024.
//

import UIKit

struct NetworkManager {
    
    static func request(for configuration: AppConfiguration) {
                
        guard let url = URL(string: configuration.rawValue) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                /*
                 Task <853B8379-F762-4ADD-8205-1094FD0F2C9A>.<1> finished with error [-1009] Error Domain=NSURLErrorDomain Code=-1009 "The Internet connection appears to be offline." UserInfo={_kCFStreamErrorCodeKey=50, NSUnderlyingError=0x600000c571b0 {Error Domain=kCFErrorDomainCFNetwork Code=-1009 "(null)" UserInfo={_kCFStreamErrorDomainKey=1, _kCFStreamErrorCodeKey=50, _NSURLErrorNWResolutionReportKey=Resolved 0 endpoints in 23ms using unknown from cache, _NSURLErrorNWPathKey=unsatisfied (No network route)}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <853B8379-F762-4ADD-8205-1094FD0F2C9A>.<1>, _NSURLErrorRelatedURLSessionTaskErrorKey=(
                     "LocalDataTask <853B8379-F762-4ADD-8205-1094FD0F2C9A>.<1>"
                 ), NSLocalizedDescription=The Internet connection appears to be offline., NSErrorFailingURLStringKey=https://swapi.dev/api/starships/3, NSErrorFailingURLKey=https://swapi.dev/api/starships/3, _kCFStreamErrorDomainKey=1}
                 */
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            
            if !((200..<300).contains(response.statusCode)) {
                return
            }
            
            guard let data else {
                return
            }
            
            print("Data: \(data)")
            print("HeaderFields: \(response.allHeaderFields)")
            print("StatusCode: \(response.statusCode)")
        }
        
        task.resume()
    }
    
}
