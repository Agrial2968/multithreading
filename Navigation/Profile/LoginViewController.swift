//
//  LoginViewController.swift
//  Navigation
//

import UIKit

final class LoginViewController: UIViewController, BruteManagerDelegate {

    var currentUserService: UserService?
    
    var delegate: LoginViewControllerDelegate?
    
    // MARK: Visual content
    
    var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var vkLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vkLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = LayoutConstants.cornerRadius
        stack.distribution = .fillProportionally
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        return stack
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let pixel = UIImage(named: "blue_pixel") {
            button.setBackgroundImage(pixel.image(alpha: 1), for: .normal)
            button.setBackgroundImage(pixel.image(alpha: 0.8), for: .selected)
            button.setBackgroundImage(pixel.image(alpha: 0.6), for: .highlighted)
            button.setBackgroundImage(pixel.image(alpha: 0.4), for: .disabled)
        }

        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(touchLoginButton), for: .touchUpInside)
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.clipsToBounds = true
        return button
    }()
    
    var loginField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.placeholder = "Log In"
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.25
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.keyboardType = .emailAddress
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.returnKeyType = .done
        return login
    }()
    
    var passwordField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leftViewMode = .always
        password.placeholder = "Password"
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.isSecureTextEntry = true
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.returnKeyType = .done
        return password
    }()
    
    var bruteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("Brute Force", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(touchBruteButton), for: .touchUpInside)
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.clipsToBounds = true
        return button
    }()
    
    let bruteManager = BruteManager()
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    // MARK: - Setup section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bruteManager.delegate = self
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        setupViews()
        configureUserService()
        #if DEBUG
        loginField.text = "agrial"
        passwordField.text = "1234"
        #endif
    }
    
    private func setupViews() {
        view.addSubview(loginScrollView)
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        loginScrollView.addSubview(contentView)
        
        contentView.addSubviews(vkLogo, loginStackView, loginButton, bruteButton)
        
        loginStackView.addArrangedSubview(loginField)
        loginStackView.addArrangedSubview(passwordField)
        
        loginField.delegate = self
        passwordField.delegate = self
        
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnScreen))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapOnScreen() {
        loginField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),
            
            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),
            
            loginStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: LayoutConstants.indent),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            bruteButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: LayoutConstants.indent),
            bruteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            bruteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            bruteButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor)
        ])
    }
    
    private func configureUserService() {
        
         #if DEBUG
        currentUserService = TestUserService(user: User(login: "test", avatar: UIImage(named: "19"), fullName: "Test Agrial", status: "Test success"))
         #else
        currentUserService = CurrentUserService(user: User(login: "agrial", avatar: UIImage(named: "20"), fullName: "Agrial West", status: "Ready to deploy"))
         #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    // MARK: - Event handlers
    
    @objc private func touchLoginButton() {
        let profileVC = ProfileViewController()
        if let login = loginField.text, !login.isEmpty, let password = passwordField.text, !password.isEmpty, let delegate = delegate, delegate.check(login: login, password: password) {
            profileVC.user = User(login: login, avatar: nil, fullName: "test", status: "test successfull")
            navigationController?.setViewControllers([profileVC], animated: true)
        } else {
            loginField.text = ""
            passwordField.text = ""
            let alert = UIAlertController(title: "Error", message: "Invalid login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
        loginField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @objc private func touchBruteButton() {
        DispatchQueue.global(qos: .background).async {
            self.bruteManager.bruteForce(passwordToUnlock: "1231")
        }
    }
    
    //MARK: - BruteManagerDelegate
    
    func startBrute() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .red
            self.activityIndicator.startAnimating()
        }
    }
    
    func finishBrute(with password: String) {
        DispatchQueue.main.async {
            self.view.backgroundColor = .green
            self.activityIndicator.stopAnimating()
            self.passwordField.text = password
            self.passwordField.isSecureTextEntry = false
        }
    }

    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentOffset.y = keyboardSize.height - (loginScrollView.frame.height - loginButton.frame.minY)
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardHide(notification: NSNotification) {
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
}

// MARK: - Extension

extension LoginViewController: UITextFieldDelegate {
    
    // tap 'done' on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
