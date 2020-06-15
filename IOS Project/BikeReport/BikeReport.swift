//
//  BikeReport.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/14.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import SwiftUI

struct BView: PreviewProvider {
    static var previews: some View {
        BikeReportView().frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
    }
}

struct BikeReportView: View {
    var body: some View {
        VStack{
            ZStack{
                Text("機車報告").font(.title).frame(alignment:.center)
            }.frame(maxWidth: .infinity)
            Divider()
            HStack{
                Text("時間區間")
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
                .border(Color.gray, width: 1)
                .cornerRadius(5)
                .padding(.horizontal, 10.0)
            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            Divider()
            FuelReport().frame(height: UIScreen.main.bounds.height/6)
            Divider()
            MaintenanceReport()
        }.frame(maxWidth: UIScreen.main.bounds.width-40)
    }
}


struct FuelReport: View{
    var body: some View{
        VStack{
            Text("油耗報告").font(.title).padding(.vertical)
            VStack{
                ReportElement(label: "總加油價格", value: "$81,000")
                ReportElement(label: "總消耗油量", value: "10公升")
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct MaintenanceReport: View{
    var body: some View{
        VStack{
            Text("保養項目報告").font(.title).padding(.vertical)
            VStack{
                ReportElement(label: "總保養價格", value: "$81,000")
                
                HStack{
                    ReportElement(label: "更換輪胎次數", value: "5次")
                    Text("總共花費 8 元").frame(alignment: .trailing)
                }.padding(.vertical, 10.0).frame(maxWidth: .infinity)
                
                HStack{
                    ReportElement(label: "更換機油次數", value: "5次")
                    Text("總共花費 8 元").frame(alignment: .trailing)
                }.padding(.vertical, 10.0).frame(maxWidth: .infinity)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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
