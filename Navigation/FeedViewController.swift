//
//  FeedViewController.swift
//  Navigation
//

import UIKit

final class FeedViewController: UIViewController {
        
    let viewModel = FeedViewModel(feedModel: FeedModel(secretWord: "peace"))
    
    private let feedTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        textField.layer.cornerRadius = LayoutConstants.cornerRadius
        return textField
    }()
    
    private var checkGuessButton = CustomButton()
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.backgroundColor = .yellow
        label.layer.cornerRadius = LayoutConstants.cornerRadius
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        setupUI(with: viewModel)
    }
    
    private func setupUI(with viewModel: FeedViewModel) {
        checkGuessButton = CustomButton(title: "Check", titleColor: .white, action: #selector (checkGuessButtonTap), target: self)
        checkGuessButton.backgroundColor =  .systemBlue
        checkGuessButton.layer.cornerRadius = LayoutConstants.cornerRadius
        view.addSubview(checkGuessButton)
        
        view.addSubview(feedTextField)
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
        
        addPostButton(title: "Number One", color: .systemCyan, to: stackView, selector: #selector(tapPostButton))
        addPostButton(title: "Number Two", color: .systemPurple, to: stackView, selector: #selector(tapPostButton))
    }
    
    private func addPostButton(title: String, color: UIColor, to view: UIStackView, selector: Selector) {
        let button = CustomButton(title: title, titleColor: .white, action: selector, target: self)
        button.backgroundColor = color
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        view.addArrangedSubview(button)
    }
    
    @objc private func tapPostButton() {
        let post = postExamples[0]
        
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc private func checkGuessButtonTap() {
        feedTextField.resignFirstResponder()
        guard let text = feedTextField.text, !text.isEmpty else { return }
        resultLabel.backgroundColor = viewModel.check(word: text)
    }
}
