//
//  InfoViewController.swift
//  Navigation
//
//  Created by user on 18.06.2024.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let button = UIButton()
        button.frame = CGRect(x: view.frame.width/2 - 50, y: view.frame.height/2 - 25, width: 100, height: 50)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    @objc func buttonTapped() {
        let alert = UIAlertController(title: "Внимание", message: "Alert Number 1", preferredStyle: .alert)
        let firstAction = UIAlertAction(title: "Назад", style: .cancel)
        let secondAction = UIAlertAction(title: "Печать", style: .default) { _ in
        print("Atantion")
        }
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        self.present(alert, animated: true)
    }
}
