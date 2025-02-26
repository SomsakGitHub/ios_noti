import UIKit
import FirebaseCore
import FirebaseMessaging

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        FirebaseApp.configure()
        
        // Apple remote notification
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

extension SceneDelegate: MessagingDelegate, UNUserNotificationCenterDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("fcmToken: \(fcmToken)")
//        AppUserDefault.shared.fcmToken = fcmToken
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("deviceToken: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
//        AppUserDefault.shared.fcmToken = Messaging.messaging().fcmToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        defer {
            completionHandler()
        }
        // when notification was tapped
        
        print("userNotificationCenter didReceive=>")
        
//        AppRedirect.shared.destination = .notification
//        LocalNotification.post(for: .notificationDidReceive)
//        LocalNotification.post(for: .shouldReloadNotificationFeed)
        
        print("original userInfo was : \(response.notification.request.content.userInfo)")
        
        if let dict = response.notification.request.content.userInfo as? [String:Any] {
            let groupId = dict["group_id"] as? String
            print("groupId=>", groupId ?? "")
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 1
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // when notification was show in foreground
        
        print("userNotificationCenter willPresent=>")
        
        // force to show red dot
//        AppUserDefault.shared.unreadNotification = 1
        
        UIApplication.shared.applicationIconBadgeNumber = 1
//        LocalNotification.post(for: .notificationDidReceive)
//        LocalNotification.post(for: .shouldReloadNotificationFeed)
        completionHandler([.badge, .sound, .banner])
    }
}

