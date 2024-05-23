//
//  RegistrationViewController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 02.04.2024.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    let usernameTextfield = CustomTextfield()
    let passwordTextfield = CustomTextfield()
    let repeatPasswordTextfield = CustomTextfield()
    
    let authService = AuthService.shared
    let databaseService = DatabaseService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        setupUI()
        
        
    }
    
    private func setupUI() {
        title = "New User"
        view.backgroundColor = .white
        
        usernameTextfield.placeholder = "Username"
        usernameTextfield.delegate = self
        
        passwordTextfield.placeholder = "Password"
        passwordTextfield.delegate = self
        
        repeatPasswordTextfield.placeholder = "Repeat Password"
        repeatPasswordTextfield.delegate = self
        
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .black
        signUpButton.layer.cornerRadius = 25
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        signUpButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        
        view.addSubview(usernameTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(repeatPasswordTextfield)
        view.addSubview(signUpButton)
        
        usernameTextfield.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().inset(20)
        }
        
        passwordTextfield.snp.makeConstraints {
            $0.top.equalTo(usernameTextfield.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().inset(20)
        }
        
        repeatPasswordTextfield.snp.makeConstraints {
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().inset(20)
        }
        
        signUpButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setBackButton() {
        navigationItem.hidesBackButton = true

        let backButtonImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .black
                
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
        
        backButton.setAttributedTitle(NSAttributedString(string: "", attributes: attributes), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    
    @objc private func registerButtonPressed() {
        
        guard let username = usernameTextfield.text, !username.isEmpty,
              let password = passwordTextfield.text, !password.isEmpty,
              let repeatPassword = repeatPasswordTextfield.text, !repeatPassword.isEmpty
        else {
            showAlert(message: "Failed to register. Please try again.")
            return
        }
        
        guard password == repeatPassword else {
            showAlert(message: "Password is not confirmed")
            return
        }
        
        Task {
            do {
                showLoader()
                let _ = try await authService.signUpUser(with: username, password: password)
                hideLoader()
                
                self.dismiss(animated: true) {
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.window?.rootViewController = TabBarController()
                    }
                }
            }
            catch {
                hideLoader()
                showAlert(message: error.localizedDescription)
            }
        }
        
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.borderStyle = .line
    }
       
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        textField.borderStyle = .none
    }
}
