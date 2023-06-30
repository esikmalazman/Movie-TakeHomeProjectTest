//
//  PersistentDelegate.swift
//  Movie+
//
//  Created by Ikmal Azman on 30/06/2023.
//

import UIKit

extension PersistentDelegate : UIApplicationDelegate {}

final class PersistentDelegate : NSObject {
    lazy var coredataStack : CoreDataStack = CoreDataStack()
    
    static let shared = PersistentDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
