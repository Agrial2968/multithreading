//
//  FeedViewController.swift
//  Navigation
//

import UIKit


class FeedModel {
    
    private let secretWord: String
    
    init(secretWord: String) {
        self.secretWord = secretWord
    }
    
    func check(word: String) -> UIColor {
        return self.secretWord == word ? .green : .red
    }
}


final class FeedViewController: UIViewController {
    
    var viewModel: FeedViewModel
        
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var feedModel = FeedModel(secretWord: "")
    
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
        ///checkButton
        checkGuessButton = CustomButton(title: viewModel.checkButtonStyle.title, titleColor: viewModel.checkButtonStyle.titleColor, action: #selector (checkGuessButtonTap), target: self)
        checkGuessButton.backgroundColor = viewModel.checkButtonStyle.color
        checkGuessButton.layer.cornerRadius = LayoutConstants.cornerRadius
        view.addSubview(checkGuessButton)
        
        ///Secret Word feed model
        feedModel = FeedModel(secretWord: viewModel.secretWord)
        
        ///Other views
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
        
        ///postButtons
        for i in 0...viewModel.postButtonStyles.count-1 {
            addPostButton(title: viewModel.postButtonStyles[i].title, color: viewModel.postButtonStyles[i].color, to: stackView, selector: #selector(tapPostButton))
        }
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
        resultLabel.backgroundColor = feedModel.check(word: text)
    }
}
