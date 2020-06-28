//
//  MaintenaceDetailView.swift
//  Rider Assistant
//
//  Created by Xiao-Allen on 2020/6/28.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import SwiftUI

struct MaintenaceDetailView: View {
    let maintenanceViewModel: MaintenanceViewModel
    let maintenanceManageVM: MaintenanceManageViewModel
    @Binding var isPresented: Bool
    @State private var maintenanceItemName = ""
    @State private var storeName = ""
    @State private var currentMilage = ""
    @State private var maintenanceDate = Date()
    @State private var cost = ""
    @State private var detailMessage = ""
    var body: some View {
        VStack{
            OptionRowElement(commonTextFieldValue: $maintenanceItemName, optionsList: MaintenanceOptions().options,label: "保養項目").padding(.vertical, 10.0)
            TextFieldRowElement(commonTextFieldValue: $storeName, label: "店家名稱").padding(.vertical, 10.0)
            NumberTextFieldRowElement(commonTextFieldValue: $currentMilage, label: "當前里程數").padding(.vertical, 10.0)
            TimeFieldRowElement(label: "保養時間", date: $maintenanceDate).padding(.vertical, 10.0)
            NumberTextFieldRowElement(commonTextFieldValue: $cost, label: "花費").padding(.vertical, 10.0)
            DetailTextFielddRowElement(commonTextFieldValue: $detailMessage, label: "備註").padding(.vertical, 10.0)
            HStack {
                Button(action: {
                    self.maintenanceManageVM.updateMaintenance(maintenanceId: self.maintenanceViewModel.id, maintenanceItemName: self.maintenanceItemName, storeName: self.storeName, currentMilage: Int32(self.currentMilage) ?? 0, maintenanceDate: self.maintenanceDate, cost: Int32(self.cost) ?? 0, detailMessage: self.detailMessage)
                    self.isPresented = false
                    
                }) {
                    Text("更新")
                }
            }
            
        }.frame(maxWidth: UIScreen.main.bounds.width-40, maxHeight: .infinity, alignment: .top).onAppear(){
            self.maintenanceItemName = self.maintenanceViewModel.name
            self.storeName = self.maintenanceViewModel.storeName
            self.currentMilage = String(self.maintenanceViewModel.milage)
            self.maintenanceDate = self.maintenanceViewModel.date
            self.cost = String(self.maintenanceViewModel.cost)
            self.detailMessage = self.maintenanceViewModel.detailMessage
        }
    }
}
