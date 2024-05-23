//
//  OrderDetailsViewController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 18.04.2024.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    var order: OrderModel?
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setupUI() {
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
        tableView.register(DetailsCell.self, forCellReuseIdentifier: "DetailsCell")
        tableView.register(OrderItemCell.self, forCellReuseIdentifier: "OrderItemCell")
        tableView.separatorStyle = .none
    }

    

}

extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let order else { return 0 }
        
        return order.carts.count + 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let order else { return UITableViewCell()}
        
        if indexPath.section <= 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
            if indexPath.section == 0 {
                cell.leftLabel.text = "Ordered"
                cell.rightLabel.text = order.setDate()
            }
            else if indexPath.section == 1 {
                cell.leftLabel.text = "\(order.numberOfItems) item: Total (Including Delivery)"
                cell.rightLabel.text = "$\(order.price)"
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderItemCell
            
            cell.configure(cart: order.carts[indexPath.section-2])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section <= 1 {
            return 50
        }
        else {
            return 160
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .bgGrayColor
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        16
    }
    
    
}
