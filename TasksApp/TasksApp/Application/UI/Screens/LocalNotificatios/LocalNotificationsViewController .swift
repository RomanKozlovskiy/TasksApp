//
//  LocalNotificationsViewController .swift
//  TasksApp
//
//  Created by user on 05.06.2024.
//

import UIKit
import UserNotifications

final class LocalNotificationsViewController: UIViewController {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private let notifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.notifyButtonTitle, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.delegate = self
        configureUI()
        configureNotificationActions()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemMint
        view.addSubview(notifyButton)
        notifyButton.tintColor = .white
        notifyButton.backgroundColor = .systemBlue
        notifyButton.frame = CGRect(x: 0, y: 0, width: 200, height: 55)
        notifyButton.center = view.center
        notifyButton.layer.cornerRadius = 15
        notifyButton.addAction(UIAction(handler: { _ in self.sendNotification() }), for: .touchUpInside)
    }
    
    private func configureNotificationActions() {
        let replyAction = UNNotificationAction(identifier: NotificationAction.reply.id, title: Constants.replyActionTitle)
        let followAction = UNNotificationAction(identifier: NotificationAction.follow.id, title: Constants.followActionTitle)
        let category = UNNotificationCategory(identifier: NotificationAction.category.id, actions: [replyAction, followAction], intentIdentifiers: [], options: .customDismissAction)
       
        notificationCenter.setNotificationCategories([category])
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = Constants.notificationContentTitle
        content.body = Constants.notificationContentBody
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = NotificationAction.category.id
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: String(describing: LocalNotificationsViewController.self), content: content, trigger: trigger)

        notificationCenter.add(request)
    }
}

extension LocalNotificationsViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case NotificationAction.reply.id:
            print("Reply action did tap")
        case NotificationAction.follow.id:
            print("Follow action did tap")
        default:
            break
        }
        
       completionHandler()
    }
}

private extension LocalNotificationsViewController {
    private enum NotificationAction {
        case reply
        case follow
        case category
        
        var id: String {
            switch self {
            case .reply:
                return "replyID"
            case .follow:
                return "followID"
            case .category:
                return "categoryID"
            }
        }
    }
    
    private enum Constants {
        static let notifyButtonTitle = "Send Local Notification"
        static let replyActionTitle = "Reply"
        static let followActionTitle = "Follow"
        static let notificationContentTitle = "Notification"
        static let notificationContentBody = "You received a local notification"
    }
}
