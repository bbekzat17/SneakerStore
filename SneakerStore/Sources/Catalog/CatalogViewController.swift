//
//  CatalogViewController.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 07.04.2024.
//

import UIKit
import SnapKit

class CatalogViewController: UIViewController {
        
    private lazy var databaseService = DatabaseService.shared
    
    var models: [ItemModel] = []
    var cartIds = [String]()
    
    private var itemsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        itemsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        setupUI()
        itemsCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: "ItemCell")
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            showLoader()
            do {
                models = try await databaseService.getCatalogItems()
                cartIds = try await databaseService.getUserItemIds()
                hideLoader()
                itemsCollectionView.reloadData()
            }
            catch{
                hideLoader()
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .bgGrayColor
        itemsCollectionView.backgroundColor = .bgGrayColor
        
        navigationItem.title = "Hello, Sneakerhead!"
        
        view.addSubview(itemsCollectionView)
        
        itemsCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }

}

extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell" , for: indexPath) as! ItemCell
        let model = models[indexPath.item]
        
        cell.isAddedToCart = cartIds.contains(model.id)
        cell.configure(with: models[indexPath.item])
        cell.delegate = self
        return cell
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
}


extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let itemWidth = (collectionViewWidth - 10) / 2
        return CGSize(width: itemWidth, height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15 // Adjust vertical spacing between rows as needed
    }
}

extension CatalogViewController: ItemCellDelegate {
    func addToCart(item: ItemModel) {
        let cart = CartModel(item: item, numberOfItems: 1)
        Task {
            do {
                try databaseService.addToCart(cartItem: cart)
            }
            catch {
                showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func removeFromCart(item: ItemModel) {
        databaseService.removeFromCart(item: item)
    }
    
    
}
