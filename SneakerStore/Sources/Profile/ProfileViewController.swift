//
//  ProfileViewController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 07.04.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let options = ProfileOptions.allCases
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    private func setupUI() {
        view.backgroundColor = .bgGrayColor
        navigationItem.title = "Profile"
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        
        
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        options.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
        cell.configure(title: options[indexPath.section].rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        16
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .bgGrayColor
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch options[indexPath.section] {
        case .accountInfo:
            let accountInfoVC = AccountInfoViewController()
            accountInfoVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(accountInfoVC, animated: true)
        case .orderHistory:
            let orderHistoryVC = OrderHistoryViewController()
            orderHistoryVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(orderHistoryVC, animated: true)
        case .shoeSize:
            let shoeSizeVC = ShoeSizeViewController()
            shoeSizeVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(shoeSizeVC, animated: true)
        }
    }
    
    
}
