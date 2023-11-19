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
    private lazy var emailStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [emailLabel, emailTextField]))

    private lazy var passwordStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [passwordLabel, newPasswordTextField, passwordConfirmationTextField]))

    private lazy var bottomStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView(arrangedSubviews: [createAccountButton, switchToLoginButton, errorLabel]))

    private lazy var parentStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 20
        return $0
    }(UIStackView(arrangedSubviews: [emailStackView, passwordStackView, bottomStackView]))

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
    
    private let createAccountButton: UIButton = {
        $0.setTitle("アカウント作成", for: .normal)
        $0.backgroundColor = .systemCyan
        return $0
    }(UIButton())
    
    private let newPasswordTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.textContentType = .newPassword
        $0.isSecureTextEntry = true
        $0.placeholder = "パスワードを入力"
        return $0
    }(UITextField())
    
    private let passwordConfirmationTextField: UITextField = {
        $0.borderStyle = .roundedRect
        $0.textContentType = .newPassword
        $0.isSecureTextEntry = true
        $0.placeholder = "パスワードを入力（確認）"
        return $0
    }(UITextField())
    
    private let errorLabel: UILabel = {
        $0.numberOfLines = 2 // 複数行表示を許可
        $0.lineBreakMode = .byWordWrapping // 単語単位で折り返す
        $0.sizeToFit()
        return $0
    }(UILabel())
    
    private let switchToLoginButton: UIButton = {
        $0.setTitle("ログインはこちら", for: .normal)
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
        createAccountButton.addAction(.init { [weak self] _ in
            guard let email = self?.emailTextField.text,
                  let password = self?.newPasswordTextField.text,
                  let passwordConfirmation = self?.passwordConfirmationTextField.text else { return }
            if (self?.checkPasswordCorrect(password: password, passwordConfirmation: passwordConfirmation) != false) {
                self?.createAccount(email: email, password: password)
            }
        }, for: .touchUpInside)
        
        switchToLoginButton.addAction(.init { [weak self] _ in
            // ログイン画面へ遷移する処理
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController, animated: true, completion: nil)
        }, for: .touchUpInside)
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
                let navigationController = UINavigationController(rootViewController: listViewController)
                self.present(navigationController, animated: true, completion: nil)
            }
        }
    }
    
    func checkPasswordCorrect(password: String, passwordConfirmation: String) -> Bool {
        if password != passwordConfirmation {
            errorLabel.text = "The Password is incorrect."
            print("The password is incorrect.")
            return false
        }
        return true
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
