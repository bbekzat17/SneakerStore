//
//  CartModel.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 15.04.2024.
//

import Foundation

struct CartModel: Codable {
    let item: ItemModel
    var numberOfItems: Int
    
    init(item: ItemModel, numberOfItems: Int) {
        self.item = item
        self.numberOfItems = numberOfItems
    }
}
