//
//  LoginPageView().swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/09/06.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LoginPageView: View {
    
    @StateObject var googleLoginVM = GoogleLoginViewModel()
    
    // Loading Indicator ....
    @State var isLoading: Bool = false
    
    @AppStorage("log_Status") var log_Status = false
    
    var body: some View {
       
        VStack {

//            Text("WallBoy")
//                .font(.largeTitle)
//                .fontWeight(.light)
//                .kerning(1.1)
//                .foregroundColor(.primary.opacity(0.8))
//                .multilineTextAlignment(.center)
//            
//            Image("santorini_1")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .cornerRadius(10)
                
            VStack(spacing: 20){
                
                Button {
                    googleLoginVM.handleLogin()
                } label: {
                    HStack(spacing: 15){
                        Image("google_login")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                        Text("Sign In with Google Account")
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .kerning(1.1)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Capsule()
                            .stroke(.primary, lineWidth: 2)
                    )
                }
            }
            .padding()
            
            Text(getAttributedString(string: "By creating an account, you are agreeing to our Terms of Service"))
                .font(.body.bold())
                .foregroundColor(.secondary)
                .kerning(1.1)
                .lineSpacing(8)
                .multilineTextAlignment(.center)
                .frame(maxHeight: .infinity, alignment: .bottom)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay(
        
            ZStack {
                
                if googleLoginVM.isLoading {
                    Color.black
                        .opacity(0.25)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .font(.title2)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                
            }
        
        )

    }
    
    func getAttributedString(string: String) -> AttributedString {
        var attributedString = AttributedString(string)
        
        if let range = attributedString.range(of: "Terms of Service") {
            
            attributedString[range].foregroundColor = .black
            attributedString[range].font = .body.bold()
        }
        
        return attributedString
    }

}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}

