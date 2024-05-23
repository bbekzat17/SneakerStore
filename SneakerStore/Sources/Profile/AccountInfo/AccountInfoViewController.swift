//
//  AccountInfoViewController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 17.04.2024.
//

import UIKit
import FirebaseAuth

class AccountInfoViewController: UIViewController {
    
    private let authService = AuthService.shared
    
    let oldPasswordTextfield = CustomTextfield()
    let newPasswordTextfield = CustomTextfield()
    let saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        setupUI()
        
        oldPasswordTextfield.delegate = self
        newPasswordTextfield.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        oldPasswordTextfield.becomeFirstResponder()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Account Information"
        
        let usernameTextfield = CustomTextfield()
        
        oldPasswordTextfield.placeholder = "old password"
        
        newPasswordTextfield.placeholder = "new password"
        
        usernameTextfield.text = authService.getUsername()
        
        saveButton.setText(text: "Save changes", color: .white, size: 17, weight: .semibold)
        saveButton.layer.cornerRadius = 25
        saveButton.backgroundColor = .black
        saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        
        view.addSubview(usernameTextfield)
        view.addSubview(oldPasswordTextfield)
        view.addSubview(newPasswordTextfield)
        view.addSubview(saveButton)
        
        usernameTextfield.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        oldPasswordTextfield.snp.makeConstraints {
            $0.top.equalTo(usernameTextfield.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        newPasswordTextfield.snp.makeConstraints {
            $0.top.equalTo(oldPasswordTextfield.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview().offset(-50)
            $0.leading.trailing.equalToSuperview().inset(16)
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
    
     @objc private func saveChanges() {
         if let oldPassword = oldPasswordTextfield.text,
            let newPassword = newPasswordTextfield.text {
             
             authService.changePassword(oldPassword: oldPassword, newPassword: newPassword) { error in
                 if let error = error {
                     // Handle error
                     print("Error changing password: \(error.localizedDescription)")
                 } else {
                     // Password changed successfully
                     print("Password changed successfully")
                 }
             }
         }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
           // Adjust the layout when the keyboard is about to be shown
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               let keyboardHeight = keyboardSize.height
               UIView.animate(withDuration: 0.3) {
                   self.saveButton.snp.makeConstraints {
                       $0.bottom.equalToSuperview().offset(-50-keyboardHeight)
                   }
               }
           }
       }
       
    @objc func keyboardWillHide(notification: NSNotification) {
        // Reset the layout when the keyboard is about to be hidden
        UIView.animate(withDuration: 0.3) {
            self.saveButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-50)
            }
        }
    }
    
    deinit {
            // Remove observers
            NotificationCenter.default.removeObserver(self)
        }
}

extension AccountInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
