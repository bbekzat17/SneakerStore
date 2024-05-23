//
//  DetailsCell.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 18.04.2024.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    let rightLabel = UILabel()
    let leftLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        leftLabel.font = .systemFont(ofSize: 13)
        
        rightLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        contentView.addSubview(rightLabel)
        contentView.addSubview(leftLabel)
        
        leftLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        rightLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
