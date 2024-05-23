//
//  AuthService.swift
//  SneakerStore
//
//  Created by Bekzat Batyrkhanov on 05.04.2024.
//

import Foundation
import FirebaseAuth

final class AuthService {
    static let shared = AuthService()
    
    private var auth = Auth.auth()
    private(set) var currentUser: AuthDataResult?
    
    private init() {}
    
    
    func signUpUser(with email: String, password: String) async throws -> AuthDataResult {
        let user = try await auth.createUser(withEmail: email, password: password)
        currentUser = user
        return user
    }
    
    func signInUser(with email: String, password: String) async throws -> AuthDataResult {
        let user = try await auth.signIn(withEmail: email, password: password)
        currentUser = user
        return user
    }
    
    func getUsername() -> String {
        if let username = currentUser?.user.email {
            return username
        }
        return ""
    }
    
    func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser,
              let email = currentUser.email  else {
            completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not signed in or missing credentials"]))
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: oldPassword)


        // Reauthenticate the user with their old password
        currentUser.reauthenticate(with: credential) { authResult, error in
            if let error = error {
                // Reauthentication failed
                completion(error)
            } else {
                // Reauthentication succeeded, proceed to change the password
                currentUser.updatePassword(to: newPassword) { error in
                    if let error = error {
                        // Password update failed
                        completion(error)
                    } else {
                        // Password updated successfully
                        completion(nil)
                    }
                }
            }
        }
    }
}
