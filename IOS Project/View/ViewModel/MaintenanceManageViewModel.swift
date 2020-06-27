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
