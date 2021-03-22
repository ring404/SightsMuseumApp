//
//  TestTaskKodeApp.swift
//  TestTaskKode
//
//  Created by Dmitrii on 05.11.2020.
//

import SwiftUI
import UIKit
//temporary commetnted out
//uncomment!
@main
struct TestTaskKodeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)    var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
class AppDelegate:  UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        let appearance = UINavigationBarAppearance()

        appearance.configureWithTransparentBackground()
//        appearance.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.118, alpha: 1)

        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.orange,
//            .font: UIFont.monospacedSystemFont(ofSize: 24, weight: .black)
               
        ]
        
        appearance.largeTitleTextAttributes = attrs

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = appearance
               UINavigationBar.appearance().compactAppearance = appearance
               UINavigationBar.appearance().scrollEdgeAppearance = appearance

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }

}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let contentView = ContentView()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}

// add gesture "back" to screens, cause originally it was removed by .navigationBarHidden(true)
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
