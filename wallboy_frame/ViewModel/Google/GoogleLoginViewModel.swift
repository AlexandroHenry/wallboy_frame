//
//  GoogleViewModel.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/13.
//

import Foundation
import Firebase
import GoogleSignIn

import SwiftUI

class GoogleLoginViewModel: ObservableObject {
    
//    @Published var currentStock = StockCurrent()
    
    @AppStorage("log_Status") var log_Status = false
    
    @Published var isLoading = false
    @Published var id = ""
    @Published var email = ""
    @Published var name = ""
    
    func handleLogin() {
        // GoogleSign In
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        
        print("clientID : \(clientID)")

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        print("config: \(config)")
        
        isLoading = true
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) {[self] user, err in
            
            if let error = err {
                isLoading = false
                print(error.localizedDescription)
              return
            }
            
            guard
              let authentication = user?.authentication,
              let idToken = authentication.idToken
            else {
                isLoading = false
              return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            // Firebase Auth ...
            Auth.auth().signIn(with: credential) { result, err in
                
                self.isLoading = false
                
                if let error = err {
                    print(error.localizedDescription)
                  return
                }
                
                // Displaying User Name...
                guard let user = result?.user else {
                    return
                }
                
                self.name = user.displayName!
                self.email = user.email!

                print(user.displayName ?? "Success!")
                
                withAnimation{
                    self.log_Status = true
                }
                
            }
        }
    }
}

extension GoogleLoginViewModel {
    // Retreiving RootView Controller...
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
