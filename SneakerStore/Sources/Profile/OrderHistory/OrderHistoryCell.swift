//
//  OrderCell.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 18.04.2024.
//

import UIKit

class OrderHistoryCell: UITableViewCell {
    
    let orderImageView = UIImageView()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let detailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        nameLabel.text = "Order #123"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(order: OrderModel) {
        dateLabel.text = order.setDate()
        detailLabel.text = "\(order.numberOfItems) item • $\(order.price)"
    }
    
    
    private func setupUI() {
        backgroundColor = .white
        
        orderImageView.image = UIImage(named: "orderImage")
        orderImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nameLabel.textColor = .black
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        
        detailLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        detailLabel.textColor = .black
        
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.lightGrayColor, renderingMode: .alwaysOriginal)
        
        contentView.addSubview(orderImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(arrowImageView)
        
        orderImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(orderImageView.snp.trailing).offset(10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        
        detailLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    
}
