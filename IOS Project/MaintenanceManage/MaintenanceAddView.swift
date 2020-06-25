//
//  MaintenanceAddView.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/15.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import SwiftUI

struct MaddView: PreviewProvider {
    static var previews: some View {
        MaintenanceAddView().frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
    }
}

struct MaintenanceAddView: View{
    @State private var milageItemName = "輪胎"
    @State private var storeName = ""
    @State private var currentMilage = ""
    @State private var milageDate = Date()
    @State private var cost = ""
    @State private var detailMessage = ""
    var body: some View {
        VStack{
            OptionRowElement(commonTextFieldValue: $milageItemName,label: "保養項目").padding(.vertical, 10.0)
            TextFieldRowElement(commonTextFieldValue: $storeName, label: "店家名稱").padding(.vertical, 10.0)
            NumberTextFieldRowElement(commonTextFieldValue: $currentMilage, label: "當前里程數").padding(.vertical, 10.0)
            TimeFieldRowElement(label: "保養時間", date: $milageDate).padding(.vertical, 10.0)
            NumberTextFieldRowElement(commonTextFieldValue: $cost, label: "花費").padding(.vertical, 10.0)
            DetailTextFielddRowElement(commonTextFieldValue: $detailMessage, label: "備註").padding(.vertical, 10.0)
            Button(action: {
                print(self.milageItemName)
                print(self.storeName)
                print(self.currentMilage)
                print(self.milageDate)
                print(self.cost)
                print(self.detailMessage)
                
            }) {
                Text("新增")
            }
        }.frame(maxWidth: UIScreen.main.bounds.width-40, maxHeight: .infinity, alignment: .top)
    }
}
