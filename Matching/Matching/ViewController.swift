//
//  ViewController.swift
//  Matching
//
//  Created by 副山俊輔 on 2023/08/26.
//

import UIKit
import SnapKit
import SwiftUI
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {
    
    private let emailLabel: UILabel = {
        return $0
    }(UILabel())
    
    private let emailTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.placeholder = "example@example.com"
        $0.autocapitalizationType = .none // 最初の文字を大文字にしない
        return $0
    }(UITextField())
    
    private let passwordLabel: UILabel = {
        return $0
    }(UILabel())
    
    private let createAccountButton: UIButton = {
        $0.setTitle("アカウント作成", for: .normal)
        $0.backgroundColor = .systemCyan
        return $0
    }(UIButton())
    
    private let passwordTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    private let errorLabel: UILabel = {
        $0.numberOfLines = 2 // 複数行表示を許可
        $0.lineBreakMode = .byWordWrapping // 単語単位で折り返す
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        emailLabel.text = "メールアドレス"
        passwordLabel.text = "パスワード"
        setConstrains()
        
        createAccountButton.addAction(.init { [weak self] _ in
            guard let email = self?.emailTextField.text,
                  let password = self?.passwordTextField.text else { return }
            self?.createAccount(email: email, password: password)
            let listViewController = ListViewController()
            let navigationController = UINavigationController(rootViewController: listViewController)
            self?.present(navigationController, animated: true, completion: nil)
        }, for: .touchUpInside)
    }
    
    
    func setConstrains() {
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(errorLabel)
        view.addSubview(createAccountButton)
        
        emailLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(140)
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
        createAccountButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextField.snp.bottom).offset(60)
            $0.width.greaterThanOrEqualTo(150)
        }
    }
    
    func createAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorLabel.text = ("\(error.localizedDescription)")
                print("Error creating user: \(error.localizedDescription)")
            } else {
                // 新しいユーザーアカウントが作成された場合の処理をここに追加
                print("User created successfully.")
                self.errorLabel.text = ""
                let listViewController = ListViewController()
                self.navigationController?.pushViewController(listViewController, animated: true)
            }
        }
    }
}

// MARK: - SwiftUI Preview Extension
extension UIViewController {
    struct PreviewWrapper: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
}

// MARK: - SwiftUI Preview Provider
struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewController.PreviewWrapper(viewController: ViewController())
            .edgesIgnoringSafeArea(.all)
    }
}
