//
//  LoaderView.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 11.04.2024.
//

import UIKit

class LoaderView: UIView {
    let loader = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        loader.center = center
        addSubview(loader)
    }
    
    func startAnimating() {
        loader.startAnimating()
    }
    
    func stopAnimating() {
        loader.stopAnimating()
    }
}
