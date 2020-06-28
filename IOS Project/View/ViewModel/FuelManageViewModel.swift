//
//  FuelManageViewModel.swift
//  IOS Project
//
//  Created by Xiao-Allen on 2020/6/27.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class FuelManageViewModel: ObservableObject {
    @Published
    var fuelConsumes = [FuelConsumeViewModel]()

    init() {
        fetchAllFuelConsumes()
    }

    private func fetchAllFuelConsumes() {
        self.fuelConsumes = CoreDataManager.shared.getAllFuelConsumes().map(FuelConsumeViewModel.init)
    }

    private func updateFuelConsumesData(update: Bool) {
        if update == true {
            fetchAllFuelConsumes()
        }
    }

    public  func addFuelConsume(fuelItemName: String, fuelCompany: String, currentMilage: Int32, fuelDate: Date, cost: Int32, detailMessage: String, fuelCapacity: Int32) -> Bool {
        var addFuelConsumeFlag:Bool
        addFuelConsumeFlag = CoreDataManager.shared.addFuelConsume(fuelItemName: fuelItemName, fuelCompany: fuelCompany, currentMilage: currentMilage, fuelDate: fuelDate, cost: cost, detailMessage: detailMessage, fuelCapacity: fuelCapacity)
        updateFuelConsumesData(update: addFuelConsumeFlag)
        return addFuelConsumeFlag
    }

    public func deleteFuelConsume(fuelConsume: FuelConsumeViewModel) {
        var deleteFlag: Bool
        deleteFlag = CoreDataManager.shared.deleteFuelConsume(fuelConsumeId: fuelConsume.id)
        updateFuelConsumesData(update: deleteFlag)
    }
}

class FuelConsumeViewModel {
    var id = UUID()
    var fuelCapacity = 0
    var fuelCompany = ""
    var name = ""
    var milage = 0
    var imageName = ""
    var detailMessage = ""
    var date = Date()
    var cost = 0

    init(fuelConsume: FuelConsume) {
        self.id = fuelConsume.id!
        self.fuelCompany = fuelConsume.fuelCompany!
        self.fuelCapacity = Int(fuelConsume.fuelCapacity)
        self.name = fuelConsume.name!
        self.milage = Int(fuelConsume.milage)
        self.imageName = fuelConsume.imageName!
        self.detailMessage = fuelConsume.detailMessage!
        self.date = fuelConsume.date!
        self.cost = Int(fuelConsume.cost)
    }
}

