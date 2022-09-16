//
//  MyInfoView.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct MyInfoView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello")
                
                Image("ProfileIMG")
            }
        }
    }
}

struct MyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MyInfoView()
    }
}
