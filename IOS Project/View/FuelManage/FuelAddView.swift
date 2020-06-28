//
//  FuelAddView.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/15.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import SwiftUI

struct FuelAddView: View{
    let fuelManageVM: FuelManageViewModel
    @Binding var isPresented: Bool
    @State private var fuelItemName = "92無鉛汽油"
    @State private var fuelCompany = "中油"
    @State private var fuelCapacity = ""
    @State private var fuelDate = Date()
    @State private var currentMilage = ""
    @State private var cost = ""
    @State private var detailMessage = ""
    var body: some View {
        VStack{
            OptionRowElement(commonTextFieldValue: $fuelItemName, label: "油品").padding(.vertical, 10.0)
            TextFieldRowElement(commonTextFieldValue: $fuelCompany, label: "石油公司").padding(.vertical, 10.0)
            NumberTextFieldRowElement(commonTextFieldValue: $fuelCapacity, label: "油量").padding(.vertical, 10.0)
            TimeFieldRowElement(label: "加油時間", date: $fuelDate).padding(.vertical, 10.0)
            NumberTextFieldRowElement(commonTextFieldValue: $currentMilage, label: "當前里程數").padding(.vertical, 10.0)
            NumberTextFieldRowElement(commonTextFieldValue: $cost, label: "花費").padding(.vertical, 10.0)
            DetailTextFielddRowElement(commonTextFieldValue: $detailMessage, label: "備註").padding(.vertical, 10.0)
            Button(action: {
                self.addFuelConsume(fuelItemName: self.fuelItemName, fuelCompany: self.fuelCompany, currentMilage: Int32(self.currentMilage) ?? 0, fuelDate: self.fuelDate, cost: Int32(self.cost) ?? 0, detailMessage: self.detailMessage, fuelCapacity: Int32(self.fuelCapacity) ?? 0)
                self.isPresented = false
            }) {
                Text("新增")
            }
        }.frame(maxWidth: UIScreen.main.bounds.width-40, maxHeight: .infinity, alignment: .top)
    }
    
    func addFuelConsume(fuelItemName: String, fuelCompany: String, currentMilage: Int32, fuelDate: Date, cost: Int32, detailMessage: String, fuelCapacity: Int32) {
        var addFuelConsumeFlag:Bool
        addFuelConsumeFlag = fuelManageVM.addFuelConsume(fuelItemName: fuelItemName, fuelCompany: fuelCompany, currentMilage: currentMilage, fuelDate: fuelDate, cost: cost, detailMessage: detailMessage, fuelCapacity: fuelCapacity)
    }
}
