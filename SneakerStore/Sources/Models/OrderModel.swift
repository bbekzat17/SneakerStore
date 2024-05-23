//
//  OrderModel.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 18.04.2024.
//

import Foundation


struct OrderModel: Codable {
    var id = UUID().uuidString
    var date = Date()
    let carts: [CartModel]
    var numberOfItems: Int {
        return carts.map { $0.numberOfItems }.reduce(0, +)
    }
    var price: Int {
        return carts.map { $0.item.price*$0.numberOfItems}.reduce(0, +)
    }
    
    func setDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
