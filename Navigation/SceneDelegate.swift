//
//  SceneDelegate.swift
//  Navigation
//
//  Created by user on 18.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let tabBerController = UITabBarController()
        
        let feedViewController = FeedViewController()
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "folder.fill"), tag: 0)
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        
        let controllers = [feedViewController, profileViewController]
        tabBerController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
}
        tabBerController.selectedIndex = 0
        
        window.rootViewController = tabBerController
        window.makeKeyAndVisible()
        
        
        self.window = window
        
    }
}
