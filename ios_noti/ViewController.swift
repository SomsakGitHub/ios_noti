import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestPermissions()
    }
    
    func requestPermissions() {
        AppPermission.shared.registerForPushNotifications{
            self.waitForNotificationSetting()
        }
    }
    
    func waitForNotificationSetting() {
        AppPermission.shared.getNotificationSettings { [weak self] status in
            print("status: \(status)")
//            guard let `self` = self else { return }
//            switch status {
//            case .notDetermined, .authorized, .denied:
//                self.requestAppTracking()
//            default:
//                self.waitForNotificationSetting()
//            }
        }
    }
}

