//
//  LoginViewController.swift
//  Matching
//
//  Created by 副山俊輔 on 2023/09/01.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let emailLabel: UILabel = {
        $0.text = "メールアドレス"
        return $0
    }(UILabel())
    
    private let emailTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.textContentType = .emailAddress
        $0.placeholder = "example@example.com"
        $0.autocapitalizationType = .none // 最初の文字を大文字にしない
        return $0
    }(UITextField())
    
    private let passwordLabel: UILabel = {
        $0.text = "パスワード"
        return $0
    }(UILabel())
    
    private let loginButton: UIButton = {
        $0.setTitle("ログイン", for: .normal)
        $0.backgroundColor = .systemCyan
        return $0
    }(UIButton())
    
    private let passwordTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.textContentType = .password
        $0.isSecureTextEntry = true
        $0.placeholder = "パスワードを入力"
        return $0
    }(UITextField())
    
    private let errorLabel: UILabel = {
        $0.numberOfLines = 2 // 複数行表示を許可
        $0.lineBreakMode = .byWordWrapping // 単語単位で折り返す
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    private let switchToCreateAccountButton: UIButton = {
        $0.setTitle("新規アカウント作成はこちら", for: .normal)
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setConstrains()
        setButtonAction()
        // Test error label
        errorLabel.text = "Test: The password must be 6 characters long or more."
    }
    
    func setConstrains() {
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(errorLabel)
        view.addSubview(loginButton)
        view.addSubview(switchToCreateAccountButton)
        
        emailLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.leftMargin.equalTo(30)
            $0.rightMargin.equalTo(30)
        }
        passwordLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailTextField.snp.bottom).offset(30)
        }
        passwordTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.leftMargin.equalTo(30)
            $0.rightMargin.equalTo(30)
        }
        errorLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.leftMargin.equalTo(30)
            $0.rightMargin.equalTo(30)
        }
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextField.snp.bottom).offset(60)
            $0.width.greaterThanOrEqualTo(150)
        }
        switchToCreateAccountButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.width.greaterThanOrEqualTo(150)
        }
    }
    
    func setButtonAction() {
        loginButton.addAction(.init { [weak self] _ in
            guard let email = self?.emailTextField.text,
                  let password = self?.passwordTextField.text else { return }
            self?.login(email: email, password: password)
        }, for: .touchUpInside)
        
        switchToCreateAccountButton.addAction(.init { [weak self] _ in
            // アカウント作成画面へ遷移する処理
            let viewController = ViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController, animated: true, completion: nil)
        }, for: .touchUpInside)
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                self?.errorLabel.text = ("\(error.localizedDescription)")
            } else {
                print("Success Login")
                self?.errorLabel.text = "Success Login"
            }
        }
    }
}
