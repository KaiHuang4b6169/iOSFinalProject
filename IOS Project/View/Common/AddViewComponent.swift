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
    @Binding var commonTextFieldValue :String
    let label: String
    var body: some View{
        HStack{
            Text(label).frame(maxWidth: UIScreen.main.bounds.width/4, alignment: .leading)
            Button(action: {}) {
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
    @Binding var commonTextFieldValue: String
    let label: String
    var body: some View{
        HStack{
            Text(label).frame(maxWidth: UIScreen.main.bounds.width/4, alignment: .leading)
            TextField("", text: $commonTextFieldValue)
            .frame(height: 30)
            .padding(.horizontal, 10.0)
            .border(Color.gray, width: 1)
        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
    }
}

struct NumberTextFieldRowElement: View{
    @Binding var commonTextFieldValue: String
    let label: String
    var body: some View{
        HStack{
            Text(label).frame(maxWidth: UIScreen.main.bounds.width/4, alignment: .leading)
            TextField("", text: $commonTextFieldValue)
            .keyboardType(.numberPad)
            .frame(height: 30)
            .padding(.horizontal, 10.0)
            .border(Color.gray, width: 1)
            
        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
    }
}

struct TimeFieldRowElement: View{
    let label: String
    @Binding var date : Date
    @State var isAddModal: Bool = false
    static let releaseFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .long
        formatter.dateFormat = "yyyy/MM/dd"
      return formatter
    }()
    var body: some View{
        HStack{
            Text(label).frame(maxWidth: UIScreen.main.bounds.width/4, alignment: .leading)
            Button(action: {
                self.isAddModal = true
            }) {
                Text(Self.releaseFormatter.string(from: self.date))
            }
            .sheet(isPresented: $isAddModal){
                DatePicker("", selection: self.$date, in: ...Date(), displayedComponents: .date)
                    .labelsHidden()
                    .environment(\.locale, Locale.init(identifier: "zh-Hant"))
                Button(action: {
                    self.isAddModal = false
                }) {
                    Text("完成")
                }
            }
            
        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
    }
}

struct DetailTextFielddRowElement: View{
    @Binding var commonTextFieldValue: String
    let label: String
    var body: some View{
        VStack{
            Text(label).padding(.top, 5.0).frame(maxWidth: .infinity, alignment: .leading)
            TextField("詳細資訊", text: $commonTextFieldValue)
            .frame(maxHeight: UIScreen.main.bounds.height/5, alignment: .topLeading)
            .padding(.horizontal, 10.0)
            .border(Color.gray, width: 1)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct ReportElement: View{
    let label: String
    let value: String
    
    var body: some View{
        HStack{
            Text(label)
            Text(value)
        }.padding(.vertical, 10.0).frame(maxWidth: .infinity, alignment: .leading)
    }
}

