//
//  FuelManage.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/14.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import SwiftUI

struct FView: PreviewProvider {
    static var previews: some View {
        FuelManage().frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
    }
}

struct FuelManage: View {
    @ObservedObject var fuelManageVM: FuelManageViewModel
    @State var timeOptions = ["一個月","三個月","六個月"]
    @State var timeSelected: String = ""
    
    init() {
        self.fuelManageVM = FuelManageViewModel()
    }
    @State var isAddModal: Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                Text("油耗管理").font(.title).frame(alignment:.center)
                Button(action: {
                    self.isAddModal = true
                }) {
                    Image(systemName: "plus.square").resizable().frame(width: 25, height: 25)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .sheet(isPresented: $isAddModal, content: {
                    FuelAddView(fuelManageVM: self.fuelManageVM, isPresented: self.$isAddModal)
                })
            }.frame(maxWidth: .infinity)
            Divider()
//            OptionRowElement(commonTextFieldValue: $timeSelected, optionsList: timeOptions,label: "時間區間").frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            List {
                ForEach(self.fuelManageVM.fuelConsumes, id: \.id) { fuelConsume in
                    FuelRowElement(fuelConsume: fuelConsume, fuelManageVM: self.fuelManageVM )
                }.onDelete(perform: deleteFuelConsume)
            }.frame(maxHeight: .infinity)
        }.frame(maxWidth: UIScreen.main.bounds.width-40)
    }
    
    func deleteFuelConsume(at offsets: IndexSet) {
        offsets.forEach { index in
            let fuelConsumeViewModel = self.fuelManageVM.fuelConsumes[index]
            self.fuelManageVM.deleteFuelConsume(fuelConsume: fuelConsumeViewModel)
        }
    }
}
