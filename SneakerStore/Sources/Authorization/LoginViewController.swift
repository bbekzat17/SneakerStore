//
//  LoginViewController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 02.04.2024.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let usernameTextfield = CustomTextfield()
    let passwordTextfield = CustomTextfield()
    
    let authService = AuthService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        setupUI()
        
    }
    
    //MARK: - UI
    
    private func setupUI() {
        title = "Welcome back!"
        view.backgroundColor = .white
        
        usernameTextfield.placeholder = "Username"
        usernameTextfield.delegate = self
        
        passwordTextfield.placeholder = "Password"
        passwordTextfield.delegate = self
        
        usernameTextfield.text = "Maksat@gmail.com"
        passwordTextfield.text = "maksat"

        let signInButton = UIButton()
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = .black
        signInButton.layer.cornerRadius = 25
        signInButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        signInButton.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        
        view.addSubview(usernameTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(signInButton)
        
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
        
        signInButton.snp.makeConstraints {
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
    
    //MARK: - ACTIONS
    
    @objc func signInPressed() {
        
        guard let username = usernameTextfield.text, !username.isEmpty,
                 let password = passwordTextfield.text, !password.isEmpty
           else {
               // Handle case where fields are empty
               return
           }
        
        Task {
            do {
                showLoader()
                let _ = try await authService.signInUser(with: username, password: password)
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

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.borderStyle = .line
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        textField.borderStyle = .none
    }
}
