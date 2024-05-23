//
//  DatabaseService.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 09.04.2024.
//

import FirebaseFirestore

final class DatabaseService {
    static let shared = DatabaseService()
    
    private init() {}
    
    private let database = Firestore.firestore()
    
    private var usersCollectionReference: CollectionReference {
        database.collection("users")
    }
    
    private var itemsCollectionReference: CollectionReference {
        database.collection("items")
    }
    
    private var cartsCollectionReference: CollectionReference? {
        guard let userId = AuthService.shared.currentUser?.user.uid else { return nil}
        return database.collection("carts/\(userId)")
    }
    
    func createUserDocument(user: UserModel) throws {
        try usersCollectionReference.document(user.id).setData(from: user)
    }
    
    func getCatalogItems() async throws -> [ItemModel] {
        try await itemsCollectionReference
            .getDocuments()
            .documents.map { try $0.data(as: ItemModel.self) }
    }
    
    func addToCart(cartItem: CartModel) throws {
        guard let userId = AuthService.shared.currentUser?.user.uid else { return }
        
        try usersCollectionReference
            .document(userId)
            .collection("cart")
            .document(cartItem.item.id)
            .setData(from: cartItem)
    }  
    
    func getUserItemIds() async throws -> [String] {
        guard let userId = AuthService.shared.currentUser?.user.uid else { return [] }
        
        return try await usersCollectionReference
            .document(userId)
            .collection("cart")
            .getDocuments()
            .documents.map { $0.documentID }
    }
    
    func getCartItems() async throws -> [CartModel] {
        guard let userId = AuthService.shared.currentUser?.user.uid else { return [] }

        let docs = try await usersCollectionReference
            .document(userId)
            .collection("cart")
            .getDocuments()
            .documents
        
        return try docs.map { document in
            try document.data(as: CartModel.self)
        }
    }
    
    func removeFromCart(item: ItemModel) {
        guard let userId = AuthService.shared.currentUser?.user.uid else { return }
        
        usersCollectionReference
            .document(userId)
            .collection("cart")
            .document(item.id)
            .delete()
    }
    
    func addToOrderHistory(order: OrderModel) throws {
        guard let userId = AuthService.shared.currentUser?.user.uid else { return }
        
        try usersCollectionReference
            .document(userId)
            .collection("orders")
            .document(order.id)
            .setData(from: order)
    }
    
    func getOrders() async throws -> [OrderModel] {
        guard let userId = AuthService.shared.currentUser?.user.uid else { return [] }
        
        let docs = try await usersCollectionReference
            .document(userId)
            .collection("orders")
            .getDocuments()
            .documents
        
        return try docs.map { document in
            try document.data(as: OrderModel.self)
        }
    }
    
    
}
