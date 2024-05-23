//
//  WelcomeViewController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 02.04.2024.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI
    private func setupUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcome-bg")
        imageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to the biggest\nsneakers store app"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .black
        signUpButton.layer.cornerRadius = 25
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        signUpButton.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        
        let signInButton = UIButton()
        signInButton.setTitle("I already have an account", for: .normal)
        signInButton.setTitleColor(.black, for: .normal)
        signInButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        signInButton.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(600)
            $0.top.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        signInButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(signUpButton.snp.bottom).offset(20)
        }
        
    }
    
    // MARK: - ACTIONS
    
    @objc private func signUpPressed() {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
    
    @objc private func signInPressed() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
        
        
}
