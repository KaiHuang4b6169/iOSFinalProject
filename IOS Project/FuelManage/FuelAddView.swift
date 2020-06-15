//
//  FuelAddView.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/15.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import SwiftUI

struct FaddView: PreviewProvider {
    static var previews: some View {
        FuelAddView().frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
    }
}

struct FuelAddView: View{
    var body: some View {
        VStack{
            OptionRowElement(label: "油品").padding(.vertical, 10.0)
            TextFieldRowElement(label: "石油公司").padding(.vertical, 10.0)
            TextFieldRowElement(label: "油量").padding(.vertical, 10.0)
            TextFieldRowElement(label: "時間").padding(.vertical, 10.0)
            TextFieldRowElement(label: "里程數").padding(.vertical, 10.0)
            TextFieldRowElement(label: "花費").padding(.vertical, 10.0)
            DetailTextFielddRowElement(label: "備註").padding(.vertical, 10.0)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("新增")
            }
        }.frame(maxWidth: UIScreen.main.bounds.width-40, maxHeight: .infinity, alignment: .top)
    }
}
