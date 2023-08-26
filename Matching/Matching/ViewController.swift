//
//  ViewController.swift
//  Matching
//
//  Created by 副山俊輔 on 2023/08/26.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {
    
    let email = "test@test.com"
    let password = "password"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                print("Error creating user: \(error.localizedDescription)")
//            } else {
//                print("User created successfully.")
//                // 新しいユーザーアカウントが作成された場合の処理をここに追加
//            }
//        }
    }
}

