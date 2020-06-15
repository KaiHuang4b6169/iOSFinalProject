//
//  AddViewComponent.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/15.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import SwiftUI

struct OptionRowElement: View{
    let label: String
    var body: some View{
        HStack{
            Text("時間區間").frame(maxWidth: UIScreen.main.bounds.width/4, alignment: .leading)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                ZStack{
                    Text("Option").foregroundColor(Color.gray)
                    Image(systemName: "arrowtriangle.down.square.fill")
                        .padding(.horizontal, 5.0)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color.gray)
                }
            }
            .frame(height: 30)
            .padding(.horizontal, 10.0)
            .border(Color.gray, width: 1)
        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
    }
}

struct TextFieldRowElement: View{
    let label: String
    var body: some View{
        HStack{
            Text(label).frame(maxWidth: UIScreen.main.bounds.width/4, alignment: .leading)
            TextField("", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            .frame(height: 30)
            .padding(.horizontal, 10.0)
            .border(Color.gray, width: 1)
            
        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
    }
}

struct DetailTextFielddRowElement: View{
    let label: String
    var body: some View{
        VStack{
            Text(label).padding(.top, 5.0).frame(maxWidth: .infinity, alignment: .leading)
            TextField("詳細資訊", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            .frame(maxHeight: UIScreen.main.bounds.height/5, alignment: .topLeading)
            .padding(.horizontal, 10.0)
            .border(Color.gray, width: 1)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
