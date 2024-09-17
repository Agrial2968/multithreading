//
//  FeedViewController.swift
//  Navigation
//

import UIKit


class FeedModel {
    
    var secretWord = "peace"
    
    func check(word: String) -> Bool {
        self.secretWord == word
    }
}


final class FeedViewController: UIViewController {
    
    let feedTextField = UITextField()
    
    lazy var checkGuessButton = CustomButton(title: "Check", titleColor: .black, action: #selector (checkGuessButtonTap), target: self)

    @objc func checkGuessButtonTap() {
        guard let text = feedTextField.text, !text.isEmpty else { return }
        
        if feedModel.check(word: text) {
            resultLabel.backgroundColor = .green
            
        } else {
            resultLabel.backgroundColor = .red
        }
        
    }
    
    var resultLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    
    let feedModel = FeedModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        
        createSubView()
    }
    
    func createSubView() {
        view.addSubview(feedTextField)
        feedTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkGuessButton)
        view.addSubview(resultLabel)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32),
    
            feedTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            feedTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            feedTextField.heightAnchor.constraint(equalToConstant: 50),
            feedTextField.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32),
            
            checkGuessButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: feedTextField.bottomAnchor, constant: 16),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            checkGuessButton.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32),
            
            resultLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 16),
            resultLabel.heightAnchor.constraint(equalToConstant: 50),
            resultLabel.widthAnchor.constraint(equalToConstant: 50)
            
        ])
        
        feedTextField.backgroundColor = .systemBackground
        feedTextField.layer.cornerRadius = LayoutConstants.cornerRadius
        checkGuessButton.backgroundColor = .red
        checkGuessButton.layer.cornerRadius = LayoutConstants.cornerRadius
        resultLabel.clipsToBounds = true
        resultLabel.backgroundColor = .yellow
        resultLabel.layer.cornerRadius = LayoutConstants.cornerRadius
        
        addPostButton(title: "Post number One", color: .systemPurple, to: stackView, selector: #selector(tapPostButton))
        addPostButton(title: "Post number Two", color: .systemIndigo, to: stackView, selector: #selector(tapPostButton))
    }
    
    private func addPostButton(title: String, color: UIColor, to view: UIStackView, selector: Selector) {
        let button = CustomButton(title: title, titleColor: .white, action: selector, target: self)
        button.backgroundColor = color
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        view.addArrangedSubview(button)
    }
    
    @objc func tapPostButton() {
        let post = postExamples[0]
        
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
}
                                  
