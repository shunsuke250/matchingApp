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
        return $0
    }(UITextField())
    
    private let passwordLabel: UILabel = {
        return $0
    }(UILabel())
    
    private let passwordTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    private let createAccountButton: UIButton = {
        $0.setTitle("アカウント作成", for: .normal)
        $0.backgroundColor = .systemCyan
        return $0
    }(UIButton())
    
    let email = "test@test.com"
    let password = "password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        emailLabel.text = "メールアドレス"
        passwordLabel.text = "パスワード"
        setConstrains()
    }
    
    //        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
    //            if let error = error {
    //                print("Error creating user: \(error.localizedDescription)")
    //            } else {
    //                print("User created successfully.")
    //                // 新しいユーザーアカウントが作成された場合の処理をここに追加
    //            }
    //        }
    
    func setConstrains() {
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        
        
        emailLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(200)
        }
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.width.equalTo(100)
        }
        passwordLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailTextField.snp.bottom).offset(100)
        }
        passwordTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.width.equalTo(100)
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
