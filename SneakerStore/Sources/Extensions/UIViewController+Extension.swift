//
//  UIViewController+Extension.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 11.04.2024.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func setupNavigationBar(with title: String) {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonPressed))
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func showLoader() {
        let loader = LoaderView(frame: view.bounds)
        view.addSubview(loader)
        loader.startAnimating()
    }
    
    func hideLoader() {
        guard let loaderView = view.subviews.last as? LoaderView else { return }
        loaderView.stopAnimating()
        loaderView.removeFromSuperview()
    }
}
