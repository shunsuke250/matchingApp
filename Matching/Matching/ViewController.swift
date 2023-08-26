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
    
    private let passwordLabel: UILabel = {
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        view.addSubview(passwordLabel)
        
        emailLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        passwordLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailLabel.snp.bottom).offset(100)
        }
    
    let email = "test@test.com"
    let password = "password"
}

// MARK: - SwiftUI Preview
struct UIViewControllerPreviewWrapper: UIViewControllerRepresentable {
    let previewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return self.previewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreviewWrapper(previewController: ViewController())
    }
}
