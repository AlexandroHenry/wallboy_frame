//
//  HomeView.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showMenu: Bool
    
    @State var indices = ["S&P", "Dow Jones", "Nasdaq", "Russell 2000", "Crude Oil", "Gold", "Silver", "EUR/USD", "10-Yr Bond", "VIX", "GBP/USD", "USD/JPY", "Bitcoin USD", "FTSE 100", "Nikkei 225"]
    
    @State var sidebarOffsetX: CGFloat = -(UIScreen.screenWidth - 90)
    
    var body: some View {
        VStack {
            
            VStack(spacing: 0) {
                
                HStack {
                    Button {
                        withAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        Text("Timeline")
                    } label: {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                
//                Divider()
            }
//            .overlay(
//                Image("Logo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 25, height: 25)
//            )
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
