//
//  OrderHistoryViewController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 17.04.2024.
//

import UIKit

class OrderHistoryViewController: UIViewController {
    
    private let databaseService = DatabaseService.shared
    
    var orders = [OrderModel]()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            do {
                showLoader()
                orders = try await databaseService.getOrders()
                hideLoader()
                
                tableView.reloadData()
            }
            catch {
                hideLoader()
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        title = "Order History"
        view.backgroundColor = .bgGrayColor
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
        tableView.register(OrderHistoryCell.self, forCellReuseIdentifier: "OrderCell")
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
    }

}

extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        orders.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderHistoryCell
        cell.configure(order: orders[indexPath.section])
        cell.nameLabel.text = "Order #\(indexPath.section+1)"
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
        let orderDetailsVC = OrderDetailsViewController()
        orderDetailsVC.order = orders[indexPath.section]
        orderDetailsVC.title = "Order #\(indexPath.section+1)"
        navigationController?.pushViewController(orderDetailsVC, animated: true)
    }
    
}
