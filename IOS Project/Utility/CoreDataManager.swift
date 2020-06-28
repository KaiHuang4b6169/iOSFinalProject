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
    
    public func updateMaintenance(maintenanceId: UUID, maintenanceItemName: String, storeName: String, currentMilage: Int32, maintenanceDate: Date, cost: Int32, detailMessage: String) -> Bool{
        var updateMaintenanceFlag : Bool = false
        let maintenances = getAllMaintenances()
        for maintenance in maintenances {
            if maintenance.id == maintenanceId {
                maintenance.name = maintenanceItemName
                maintenance.storeName = storeName
                maintenance.milage = currentMilage
                maintenance.date = maintenanceDate
                maintenance.cost = cost
                maintenance.detailMessage = detailMessage
                updateMaintenanceFlag = saveContext()
            }
        }
        
        return updateMaintenanceFlag
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
    
    public func getAllFuelConsumes() -> [FuelConsume] {
        var fuelConsumes = [FuelConsume]()
        let fuelConsumeRequest : NSFetchRequest<FuelConsume> = FuelConsume.fetchRequest()
        
        do {
            fuelConsumes = try self.moc.fetch(fuelConsumeRequest)
        }catch let error as NSError{
            print(error)
        }
        return fuelConsumes
    }
    
    func addFuelConsume(fuelItemName: String, fuelCompany: String, currentMilage: Int32, fuelDate: Date, cost: Int32, detailMessage: String, fuelCapacity: Int32) ->Bool {
        var saveFlag : Bool
        let newFuelConsume = FuelConsume(context: self.moc)
        
        newFuelConsume.id = UUID()
        newFuelConsume.name = fuelItemName
        newFuelConsume.fuelCompany = fuelCompany
        newFuelConsume.milage = currentMilage
        newFuelConsume.cost = cost
        newFuelConsume.detailMessage = detailMessage
        newFuelConsume.date = fuelDate
        newFuelConsume.imageName = fuelItemName
        newFuelConsume.fuelCapacity = fuelCapacity
        // 3
        saveFlag = saveContext()
        return saveFlag
        
    }
    
    public func deleteFuelConsume(fuelConsumeId: UUID) -> Bool{
        var deleteFuelConsumeFlag : Bool
        let fuelConsumes = getAllFuelConsumes()
        for fuelConsume in fuelConsumes {
            if fuelConsume.id == fuelConsumeId {
                self.moc.delete(fuelConsume)
            }
        }
        deleteFuelConsumeFlag = saveContext()
        return deleteFuelConsumeFlag
    }
    
    public func updateFuelConsume(fuelConsumeId: UUID, fuelItemName: String, fuelCompany: String, currentMilage: Int32, fuelDate: Date, cost: Int32, detailMessage: String, fuelCapacity: Int32) -> Bool {
        var updateFuelConsumeFlag : Bool = false
        let fuelConsumes = getAllFuelConsumes()
        for fuelConsume in fuelConsumes {
            if fuelConsume.id == fuelConsumeId {
                fuelConsume.name = fuelItemName
                fuelConsume.fuelCompany = fuelCompany
                fuelConsume.milage = currentMilage
                fuelConsume.date = fuelDate
                fuelConsume.cost = cost
                fuelConsume.detailMessage = detailMessage
                fuelConsume.fuelCapacity = fuelCapacity
               updateFuelConsumeFlag = saveContext()
            }
        }
        
        return updateFuelConsumeFlag
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
