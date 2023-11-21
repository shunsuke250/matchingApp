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
    private lazy var emailStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [emailLabel, emailTextField]))

    private lazy var passwordStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [passwordLabel, passwordTextField]))

    private lazy var topStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 20
        return $0
    }(UIStackView(arrangedSubviews: [emailStackView, passwordStackView]))

    private lazy var bottomStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView(arrangedSubviews: [loginButton, switchToCreateAccountButton, errorLabel]))
    
    private lazy var parentStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 60
        return $0
    }(UIStackView(arrangedSubviews: [topStackView, bottomStackView]))
    
    private let emailLabel: UILabel = {
        $0.text = "メールアドレス"
        $0.textAlignment = .center
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
        $0.textAlignment = .center
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
    }
    
    func setConstrains() {
        view.addSubview(parentStackView)
        
        parentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
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
            if let error = error {
                self?.errorLabel.text = ("\(error.localizedDescription)")
            } else {
                print("Success Login")
                // ListViewControllerへ画面遷移
                let listViewController = ListViewController()
                let navigationController = UINavigationController(rootViewController: listViewController)
                navigationController.modalPresentationStyle = .fullScreen
                self?.present(navigationController, animated: true, completion: nil)
            }
        }
    }
}
