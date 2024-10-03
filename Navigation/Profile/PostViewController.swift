//
//  PostViewController.swift
//  Navigation
//

import UIKit
import StorageService

final class PostViewController: UIViewController {
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post?.author ?? "-"
        
#if DEBUG
        view.backgroundColor = .lightGray
#else
        view.backgroundColor = .systemYellow
#endif
        
        // add a button in the navigtion bar
        let barButton = UIBarButtonItem(title: "Info", style: .done, target: self, action: #selector(tapInfoButton))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func tapInfoButton() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }
}
