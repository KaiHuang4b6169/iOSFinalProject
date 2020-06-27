//
//  CoreDataManager.swift
//  IOS Project
//
//  Created by Xiao-Allen on 2020/6/26.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    public func getAllMaintenances() -> [Maintenance] {
        var maintenances = [Maintenance]()
        let maintenanceRequest : NSFetchRequest<Maintenance> = Maintenance.fetchRequest()
        
        do {
            maintenances = try self.moc.fetch(maintenanceRequest)
        }catch let error as NSError{
            print(error)
        }
        return maintenances
    }
    
    public func addMaintenance(maintenanceItemName: String, storeName: String, currentMilage: Int32, maintenanceDate: Date, cost: Int32, detailMessage: String) ->Bool {
        // 1
        var saveFlag : Bool
        let newMaintenance = Maintenance(context: self.moc)
        
        // 2
        newMaintenance.id = UUID()
        newMaintenance.name = maintenanceItemName
        newMaintenance.storeName = storeName
        newMaintenance.milage = currentMilage
        newMaintenance.cost = cost
        newMaintenance.detailMessage = detailMessage
        newMaintenance.date = maintenanceDate
        newMaintenance.imageName = maintenanceItemName
        // 3
        saveFlag = saveContext()
        return saveFlag
    }
    
    public func deleteMaintenance(maintenanceId: UUID) -> Bool{
        var deleteMaintenanceFlag : Bool
        let maintenances = getAllMaintenances()
        for maintenance in maintenances {
            if maintenance.id == maintenanceId {
                self.moc.delete(maintenance)
            }
        }
        deleteMaintenanceFlag = saveContext()
        return deleteMaintenanceFlag
    }
    
    private func saveContext() -> Bool{
        var saveFlag = false
        do {
            try self.moc.save()
            saveFlag.toggle()
        } catch {
            print("Error saving managed object context: \(error)")
        }
        return saveFlag
    }
}
