//
//  ContentView.swift
//  wallboy_frame
//
//  Created by Seungchul Ha on 2022/08/15.
//

import SwiftUI
import CoreData
import Firebase
import GoogleSignIn

struct ContentView: View {
    
    @AppStorage("log_Status") var log_Status = false
    
    var body: some View {
        if log_Status {
            BaseView()
        } else {
            LoginPageView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(ModelData())
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension Date {
    var onlyDate: Date? {
        get {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
            return calendar.date(from: dateComponents)
        }
    }
}

extension View {
    
    /// 탭바 숨김 처리 여부
    /// - Parameter isHidden:
    /// - Returns:
    func setTabBarVisibility(isHidden : Bool) -> some View {
      background(TabBarAccessor { tabBar in
          print(">> TabBar height: \(tabBar.bounds.height)")
          // !! use as needed, in calculations, @State, etc.
          // 혹은 높이를 변경한다던지 여러가지 설정들이 가능하다.
          tabBar.isHidden = isHidden
      })
  }
}

// Helper bridge to UIViewController to access enclosing UITabBarController
// and thus its UITabBar
struct TabBarAccessor: UIViewControllerRepresentable {
    var callback: (UITabBar) -> Void
    private let proxyController = ViewController()

    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
                              UIViewController {
        proxyController.callback = callback
        return proxyController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }

    typealias UIViewControllerType = UIViewController

    // viewWillAppear 가 탈때 가지고 있는 탭바를 클로저 콜백으로 넘겨준다.
    private class ViewController: UIViewController {
        var callback: (UITabBar) -> Void = { _ in }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let tabBar = self.tabBarController {
                self.callback(tabBar.tabBar)
            }
        }
    }
}
