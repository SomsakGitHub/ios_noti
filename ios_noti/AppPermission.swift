import UserNotifications
import UIKit

public final class AppPermission {
    public static let shared = AppPermission()
    
    //MARK : - Remote Notification
    // https://stackoverflow.com/a/40531322
    public func registerForPushNotifications( callback: @escaping(() -> Void)) {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    callback()
                }
            }
    }
    
    public func getNotificationSettings(callback: @escaping ((UNAuthorizationStatus) -> Void)) {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { permission in
            callback(permission.authorizationStatus)
        })
    }
}
