//
//  ShoeSizeViewController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 17.04.2024.
//

import UIKit

class ShoeSizeViewController: UIViewController {
    
    private let textfield = CustomTextfield()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        title = "Shoe Size"
        view.backgroundColor = .white
        
        textfield.keyboardType = .asciiCapableNumberPad
        textfield.becomeFirstResponder()
        
        view.addSubview(textfield)
        
        textfield.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(10)
        }
    }
    

   
}
