//
//  CartViewController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 07.04.2024.
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    
    private lazy var databaseService = DatabaseService.shared
    
    var carts = [CartModel]()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .bgGrayColor
        navigationItem.title = "Cart"
        
        
        let confirmOrderButton = UIButton()
        confirmOrderButton.setText(text: "Confirm Order", color: .white, size: 17, weight: .semibold)
        confirmOrderButton.layer.cornerRadius = 25
        confirmOrderButton.backgroundColor = .black
        confirmOrderButton.addTarget(self, action: #selector(confirmOrderButtonPressed), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(confirmOrderButton)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
        
        confirmOrderButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    private func configTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell")
        tableView.rowHeight = 160
        tableView.separatorStyle = .none
        
    }
    
    private func loadData() {
        Task {
            showLoader()
            
            do {
                carts = try await databaseService.getCartItems()
                hideLoader()
                
                tableView.reloadData()
            }
            catch {
                hideLoader()
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
    
    @objc private func confirmOrderButtonPressed() {
        let order = OrderModel(carts: carts)
        Task {
            do {
                try databaseService.addToOrderHistory(order: order)
                print("Added to order History")
            }
            catch{
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        carts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         16
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .bgGrayColor
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.selectionStyle = .none
        
        cell.configure(cart: carts[indexPath.section])
        
        cell.onQuantityWasChanged = { [weak self] number in
            guard let self else { return }
            self.carts[indexPath.section].numberOfItems = number
            try self.databaseService.addToCart(cartItem: self.carts[indexPath.section])
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let self else { return }
            
            self.databaseService.removeFromCart(item: self.carts[indexPath.section].item)
            self.carts.remove(at: indexPath.section)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}
