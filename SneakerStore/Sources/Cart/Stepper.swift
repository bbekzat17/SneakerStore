//
//  Stepper.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 15.04.2024.
//

import UIKit
import SnapKit

final class Stepper: UIControl {
    var currentValue = 1 {
        didSet {
            currentValue = currentValue > 0 ? currentValue : 0
            currentStepValueLabel.text = "\(currentValue)"
        }
    }
    
    var currentStepValueLabel = UILabel()
    
    let decreaseButton = UIButton()
    
    let increaseButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        decreaseButton.setTitleColor(.white, for: .normal)
        let minusImage = UIImage(systemName: "minus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        decreaseButton.setImage(minusImage, for: .normal)
        decreaseButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        increaseButton.setTitleColor(.white, for: .normal)
        let plusImage = UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        increaseButton.setImage(plusImage, for: .normal)
        increaseButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        currentStepValueLabel.textColor = .white
        currentStepValueLabel.text = "\(currentValue)"
        currentStepValueLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: UIFont.Weight.regular)
        
        addSubview(currentStepValueLabel)
        addSubview(decreaseButton)
        addSubview(increaseButton)
        
        decreaseButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.centerY.equalToSuperview()
        }
        
        increaseButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-30)
            $0.centerY.equalToSuperview()
        }
        
        currentStepValueLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            currentValue -= 1
        case increaseButton:
            currentValue += 1
        default:
            break
        }
        sendActions(for: .valueChanged)
    }
    
    
}
