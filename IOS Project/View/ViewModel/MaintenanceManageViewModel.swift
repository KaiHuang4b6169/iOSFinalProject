//
//  MaintenanceManageViewModel.swift
//  IOS Project
//
//  Created by Xiao-Allen on 2020/6/26.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MaintenanceManageViewModel: ObservableObject {
    @Published
    var maintenances = [MaintenanceViewModel]()
    
    init() {
        fetchAllMaintenances()
    }
    
    private func fetchAllMaintenances() {
        self.maintenances = CoreDataManager.shared.getAllMaintenances().map(MaintenanceViewModel.init)
    }
    
    private func updateMaintenancesData(update: Bool) {
        if update == true {
            fetchAllMaintenances()
        }
    }
    
    public  func addMaintenance(maintenanceItemName: String, storeName: String, currentMilage: Int32, maintenanceDate: Date, cost: Int32, detailMessage: String) -> Bool {
        var addMaintenanceFlag: Bool
        addMaintenanceFlag = CoreDataManager.shared.addMaintenance(maintenanceItemName: maintenanceItemName, storeName: storeName, currentMilage: currentMilage, maintenanceDate: maintenanceDate, cost: cost, detailMessage: detailMessage)
        updateMaintenancesData(update: addMaintenanceFlag)
        return addMaintenanceFlag
    }
    
    public func deleteMaintenance(maintenance: MaintenanceViewModel) {
        var deleteFlag: Bool
        deleteFlag = CoreDataManager.shared.deleteMaintenance(maintenanceId: maintenance.id)
        updateMaintenancesData(update: deleteFlag)
    }
    
    public func getReportData()  -> (Array<Int>, Array<Int>, Array<Int>, Array<Int>, Array<Int>){
        updateMaintenancesData(update: true)
        
        var tireData = [0, 0]
        var motorOilData = [0, 0]
        var batteryData = [0, 0]
        var marsPlugData = [0, 0]
        var gearOilData = [0, 0]
        for maintenance in maintenances {
            if maintenance.name == MaintenanceOptions().options[0] {
                tireData[0] = tireData[0] + 1
                tireData[1] = tireData[1] + maintenance.cost
            }else if maintenance.name == MaintenanceOptions().options[1] {
                motorOilData[0] = motorOilData[0] + 1
                motorOilData[1] = motorOilData[1] + maintenance.cost
            }else if maintenance.name == MaintenanceOptions().options[2] {
                batteryData[0] = batteryData[0] + 1
                batteryData[1] = batteryData[1] + maintenance.cost
            }else if maintenance.name == MaintenanceOptions().options[3] {
                marsPlugData[0] = marsPlugData[0] + 1
                marsPlugData[1] = marsPlugData[1] + maintenance.cost
            }else if maintenance.name == MaintenanceOptions().options[4] {
                gearOilData[0] = gearOilData[0] + 1
                gearOilData[1] = gearOilData[1] + maintenance.cost
            }
        }
        
        return (tireData, motorOilData, batteryData, marsPlugData, gearOilData)
     }
}


class MaintenanceViewModel {
    var id = UUID()
    var storeName = ""
    var name = ""
    var milage = 0
    var imageName = ""
    var detailMessage = ""
    var date = Date()
    var cost = 0
    
    init(maintenance: Maintenance) {
        self.id = maintenance.id!
        self.storeName = maintenance.storeName!
        self.name = maintenance.name!
        self.milage = Int(maintenance.milage)
        self.imageName = maintenance.imageName!
        self.detailMessage = maintenance.detailMessage!
        self.date = maintenance.date!
        self.cost = Int(maintenance.cost)
    }
}
