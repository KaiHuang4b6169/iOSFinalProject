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
    var body: some View {
        VStack{
            OptionRowElement(label: "保養項目").padding(.vertical, 10.0)
            TextFieldRowElement(label: "店家名稱").padding(.vertical, 10.0)
            TextFieldRowElement(label: "當前里程數").padding(.vertical, 10.0)
            TextFieldRowElement(label: "時間").padding(.vertical, 10.0)
            TextFieldRowElement(label: "花費").padding(.vertical, 10.0)
            DetailTextFielddRowElement(label: "備註").padding(.vertical, 10.0)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("新增")
            }
        }.frame(maxWidth: UIScreen.main.bounds.width-40, maxHeight: .infinity, alignment: .top)
    }
}
