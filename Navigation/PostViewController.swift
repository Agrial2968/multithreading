//
//  PostViewController.swift
//  Navigation
//
//  Created by user on 18.06.2024.
//

import Foundation
import UIKit

class PostViewController: UIViewController {
    
    var post = Post(title: "Пост")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "pencil"),
            style: .done,
            target: self,
            action: #selector(navigationButtonTapped)
        )
        title = post.title
    }
    
    @objc func navigationButtonTapped() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .popover
        self.present(infoViewController, animated: true)
    }
    
}
