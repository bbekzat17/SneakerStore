//
//  OrderItemCell.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 18.04.2024.
//

import UIKit
import SnapKit

class OrderItemCell: UITableViewCell {
    
    
    let cartImageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func configure(cart: CartModel) {
        setupImage(with: cart)
        nameLabel.text = cart.item.name
        descriptionLabel.text = cart.item.description
        priceLabel.text = " \(cart.numberOfItems) • $\(cart.item.price)"
        
    }
    
    private func setupImage(with model: CartModel) {
        let placeholderImage = UIImage(systemName: "smiley")
        let imageURL = StorageService.shared.imageURL(for: model.item.image)
        
        imageURL.getData(maxSize: 1*1024*1024) { [weak self] result in
            switch result {
            case .success(let data):
                self?.cartImageView.image = UIImage(data: data)
            case .failure(_):
                print("ERRRRRROR!!!")
                self?.cartImageView.image = placeholderImage
            }
        }
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        cartImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 13, weight: .semibold)

        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .gray
        
        priceLabel.textAlignment = .left
        priceLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        
        
        contentView.addSubview(cartImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        
        cartImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.height.width.equalTo(140)
            $0.leading.equalToSuperview().offset(16)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalTo(cartImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing).offset(-16)
        }
    }
}

