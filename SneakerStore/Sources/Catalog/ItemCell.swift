//
//  ItemCell.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 11.04.2024.
//

import UIKit

protocol ItemCellDelegate: AnyObject {
    func addToCart(item: ItemModel)
    func removeFromCart(item: ItemModel)
}

class ItemCell: UICollectionViewCell {
    static let cellIdentifier = "ItemCell"
    weak var delegate: ItemCellDelegate?
    
    private var model: ItemModel?
    
    var isAddedToCart = false {
        didSet {
            let title = isAddedToCart ? "Remove" : "Add to Cart"
            let color: UIColor = isAddedToCart ? .black.withAlphaComponent(0.8) : .black
            
            addToCartButton.setText(text: title, color: .white, size: 15, weight: .semibold)
            addToCartButton.backgroundColor = color
        }
    }
    
    var isButtonPressed = false

    let imageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let priceLabel = UILabel()
    let addToCartButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ItemModel) {
        self.model = model
        
        setupImage(with: model)
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        priceLabel.text = "$\(model.price)"
    }
    
    private func setupImage(with model: ItemModel) {
        let placeholderImage = UIImage(systemName: "smiley")
        let imageURL = StorageService.shared.imageURL(for: model.image)
        
        imageURL.getData(maxSize: 1*1024*1024) { [weak self] result in
            switch result {
            case .success(let data):
                self?.imageView.image = UIImage(data: data)
            case .failure(_):
                print("ERRRRRROR!!!")
                self?.imageView.image = placeholderImage
            }
        }
    }
    
    private func setupView() {
        layer.cornerRadius = 5
        backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .gray
        
        priceLabel.textAlignment = .left
        priceLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        
        addToCartButton.layer.cornerRadius = 20
        addToCartButton.backgroundColor = .black
        addToCartButton.setText(text: "Add to cart", color: .white, size: 15, weight: .semibold)
        
        addToCartButton.addTarget(self, action: #selector(onButtonPressed), for: .touchUpInside)

        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(addToCartButton)
        
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        addToCartButton.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
    }
    
    @objc func onButtonPressed() {
        guard let model else { return }
        
        isAddedToCart ? delegate?.removeFromCart(item: model) : delegate?.addToCart(item: model)
        
        isAddedToCart.toggle()
    }
    
    
}
