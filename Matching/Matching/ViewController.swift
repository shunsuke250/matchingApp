//
//  ViewController.swift
//  Matching
//
//  Created by 副山俊輔 on 2023/08/26.
//

import UIKit
import SnapKit
import SwiftUI

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
    }


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
