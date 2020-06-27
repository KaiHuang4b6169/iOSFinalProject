//
//  NSManagedObjectContextExtensions.swift
//  IOS Project
//
//  Created by Xiao-Allen on 2020/6/26.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
