//
//  FuelDetailView.swift
//  Rider Assistant
//
//  Created by Xiao-Allen on 2020/6/28.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import SwiftUI

struct FuelDetailView: View {
    let fuelConsumeViewModel: FuelConsumeViewModel
    let fuelManageVM: FuelManageViewModel
    @Binding var isPresented: Bool
    @State private var fuelItemName = ""
    @State private var fuelItemNameList = ["92無鉛汽油","95無鉛汽油","98無鉛汽油"]
    @State private var fuelCompany = "中油"
    @State private var fuelCapacity = ""
    @State private var fuelDate = Date()
    @State private var currentMilage = ""
    @State private var cost = ""
    @State private var detailMessage = ""
    var body: some View {
        VStack{
            OptionRowElement(commonTextFieldValue: $fuelItemName, optionsList: fuelItemNameList, label: "油品").padding(.vertical, 10.0)
            TextFieldRowElement(commonTextFieldValue: $fuelCompany, label: "石油公司").padding(.vertical, 10.0)
            NumberTextFieldRowElement(commonTextFieldValue: $fuelCapacity, label: "油量").padding(.vertical, 10.0)
            TimeFieldRowElement(label: "加油時間", date: $fuelDate).padding(.vertical, 10.0)
            NumberTextFieldRowElement(commonTextFieldValue: $currentMilage, label: "當前里程數").padding(.vertical, 10.0)
            NumberTextFieldRowElement(commonTextFieldValue: $cost, label: "花費").padding(.vertical, 10.0)
            DetailTextFielddRowElement(commonTextFieldValue: $detailMessage, label: "備註").padding(.vertical, 10.0)
            Button(action: {
                self.fuelManageVM.updateFuelConsume(fuelConsumeId: self.fuelConsumeViewModel.id, fuelItemName: self.fuelItemName, fuelCompany: self.fuelCompany, currentMilage: Int32(self.currentMilage) ?? 0, fuelDate: self.fuelDate, cost: Int32(self.cost) ?? 0, detailMessage: self.detailMessage, fuelCapacity: Int32(self.fuelCapacity) ?? 0)
                self.isPresented = false
            }) {
                Text("更新")
            }
        }.frame(maxWidth: UIScreen.main.bounds.width-40, maxHeight: .infinity, alignment: .top).onAppear(){
            self.fuelItemName = self.fuelConsumeViewModel.name
            self.fuelCompany = self.fuelConsumeViewModel.fuelCompany
            self.fuelCapacity = String(self.fuelConsumeViewModel.fuelCapacity)
            self.fuelDate = self.fuelConsumeViewModel.date
            self.currentMilage = String(self.fuelConsumeViewModel.milage)
            self.cost = String(self.fuelConsumeViewModel.cost)
            self.detailMessage = self.fuelConsumeViewModel.detailMessage
        }
    }
}


