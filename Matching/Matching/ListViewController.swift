//
//  ListViewController.swift
//  Matching
//
//  Created by 副山俊輔 on 2023/08/28.
//

import UIKit

class ListViewController: UIViewController {
    
    private let tableView: UITableView = {
        return $0
    }(UITableView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        setConstrains()
    }
    
    func setConstrains() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.margins.equalTo(0)
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "cell: \(indexPath.row)"

        return cell
    }
}
