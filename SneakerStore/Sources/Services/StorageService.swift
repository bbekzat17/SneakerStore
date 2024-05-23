//
//  StorageService.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 15.04.2024.
//

import FirebaseStorage

final class StorageService {
    static let shared = StorageService()
    
    private init() {}
    
    private let storage = Storage.storage()
    
    private var imagesReference: StorageReference {
        storage.reference()
    }
    
    func imageURL( for name: String) -> StorageReference {
        imagesReference.child(name)
    }
}
