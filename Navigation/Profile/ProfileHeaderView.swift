//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by user on 19.06.2024.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let profileNameLabel = UILabel()
    let profileImageView = UIImageView()
    let profileStatusLabel = UILabel()
    let showStatusButton = UIButton()
    let statusTextField = NiceTextField()
    
    private var statusText: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.borderWidth = 3.0
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.image = UIImage(named: "cat")
        profileImageView.clipsToBounds = true
        
        profileNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        profileNameLabel.textColor = .black
        profileNameLabel.text = "Hipster Cat"
        
        profileStatusLabel.text = "Waiting for something..."
        profileStatusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        profileStatusLabel.textColor = .gray
        
        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.layer.cornerRadius = 4
        showStatusButton.layer.shadowColor = UIColor.black.cgColor
        showStatusButton.layer.shadowRadius = 4
        showStatusButton.layer.shadowOpacity = 0.7
        showStatusButton.layer.shadowOffset = .init(width: 4, height: 4)
        showStatusButton.setTitle("Show status", for: .normal)
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        statusTextField.backgroundColor = .white
        statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1.0
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.addTarget(self, action: #selector(statusTextChanged(_ :)), for: .editingChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(profileImageView)
        addSubview(profileNameLabel)
        addSubview(profileStatusLabel)
        addSubview(showStatusButton)
        addSubview(statusTextField)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        showStatusButton.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            profileNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            profileNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16),
            profileNameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            profileNameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            profileStatusLabel.leftAnchor.constraint(equalTo: profileNameLabel.leftAnchor),
            profileStatusLabel.rightAnchor.constraint(equalTo: profileNameLabel.rightAnchor),
            profileStatusLabel.heightAnchor.constraint(equalToConstant: 24),
            profileStatusLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 8),
            
            showStatusButton.leftAnchor.constraint(equalTo: profileImageView.leftAnchor),
            showStatusButton.rightAnchor.constraint(equalTo: profileNameLabel.rightAnchor),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            showStatusButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            
            statusTextField.leftAnchor.constraint(equalTo: profileStatusLabel.leftAnchor),
            statusTextField.rightAnchor.constraint(equalTo: profileStatusLabel.rightAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.topAnchor.constraint(equalTo: profileStatusLabel.bottomAnchor, constant: 8)
            
        ])
    }
            
    @objc func buttonPressed() {
        profileStatusLabel.text = statusText
        statusTextField.text = ""
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
    }
}

class NiceTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds.inset(by: padding))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds.inset(by: padding))
    }
}
