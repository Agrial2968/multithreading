//
//  FeedViewController.swift
//  Navigation
//
//  Created by user on 18.06.2024.
//

import UIKit

class FeedViewController: UIViewController {
    
    let post = Post(title: "Первый пост")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let button = UIButton()
        button.frame = CGRect(x: view.frame.width/2 - 50, y: view.frame.height/2 - 25, width: 100, height: 50)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonTapped() {
        let postViewController = PostViewController()
        postViewController.post = post
        navigationController?.pushViewController(postViewController, animated: true)
    }
}



