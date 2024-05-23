//
//  ProfileTableViewCell.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 17.04.2024.
//

import UIKit
import SnapKit
class ProfileTableViewCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        nameLabel.text = title
    }
    
    private func setupUI() {
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.lightGrayColor, renderingMode: .alwaysOriginal)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageView)
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    
}
