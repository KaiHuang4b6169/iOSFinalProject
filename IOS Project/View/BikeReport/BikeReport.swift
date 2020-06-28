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
    @State var timeOptions = ["一個月","三個月","六個月"]
    @State var timeSelected: String = ""
    var body: some View {
        VStack{
            ZStack{
                Text("機車報告").font(.title).frame(alignment:.center)
            }.frame(maxWidth: .infinity)
//            OptionRowElement(commonTextFieldValue: $timeSelected, optionsList: timeOptions,label: "時間區間").frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            Divider()
            FuelReport().frame(height: UIScreen.main.bounds.height/6)
            Divider()
            MaintenanceReport()
        }.frame(maxWidth: UIScreen.main.bounds.width-40)
    }
}


struct FuelReport: View{
    @State var totalAddFuelCost: String = "$0"
    @State var totalFuelCapacity: String = "0公升"
    var body: some View{
        VStack{
            Text("油耗報告").font(.headline).padding(.vertical)
            VStack{
                ReportElement(label: "總加油價格", value: totalAddFuelCost)
                ReportElement(label: "總消耗油量", value: totalFuelCapacity)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).onAppear(){
            let fuelManageVM = FuelManageViewModel()
            let fuelReportData = fuelManageVM.getReportData()
            self.totalAddFuelCost = "$" + "\(fuelReportData.0)"
            self.totalFuelCapacity = "\(fuelReportData.1)" + "公升"
        }
        
    }
}

struct MaintenanceReport: View{
    @State var totalMaintenenceCost: String = "$0"
    @State var tireData = [0, 0]
    @State var motorOilData = [0, 0]
    @State var batteryData = [0, 0]
    @State var marsPlugData = [0, 0]
    @State var gearOilData = [0, 0]
    var body: some View{
        VStack{
            Text("保養項目報告").font(.headline).padding(.vertical)
            VStack{
                ReportElement(label: "總保養價格", value: totalMaintenenceCost)
                List{
                    HStack{
                        ReportElement(label: "更換輪胎次數", value: "\(tireData[0])")
                        Text("總共花費" + "\(tireData[1])"  + "元").frame(alignment: .trailing)
                    }.padding(.vertical, 10.0).frame(maxWidth: .infinity)
                    HStack{
                        ReportElement(label: "更換機油次數", value: "\(motorOilData[0])")
                        Text("總共花費" + "\(motorOilData[1])"  + "元").frame(alignment: .trailing)
                    }.padding(.vertical, 10.0).frame(maxWidth: .infinity)
                    HStack{
                        ReportElement(label: "更換電瓶次數", value: "\(batteryData[0])")
                        Text("總共花費" + "\(batteryData[1])"  + "元").frame(alignment: .trailing)
                    }.padding(.vertical, 10.0).frame(maxWidth: .infinity)
                    HStack{
                        ReportElement(label: "更換火星塞次數", value: "\(marsPlugData[0])")
                        Text("總共花費" + "\(marsPlugData[1])"  + "元").frame(alignment: .trailing)
                    }.padding(.vertical, 10.0).frame(maxWidth: .infinity)
                    HStack{
                        ReportElement(label: "更換齒輪油次數", value: "\(gearOilData[0])")
                        Text("總共花費" + "\(gearOilData[1])"  + "元").frame(alignment: .trailing)
                    }.padding(.vertical, 10.0).frame(maxWidth: .infinity)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).onAppear(){
            let maintenenceManageVM = MaintenanceManageViewModel()
            let maintenenceData = maintenenceManageVM.getReportData()
            var totalCost = 0
            totalCost = maintenenceData.0[1] + maintenenceData.1[1] + maintenenceData.2[1] + maintenenceData.3[1] + maintenenceData.4[1]
            self.totalMaintenenceCost = "$" + "\(totalCost)"
            self.tireData = maintenenceData.0
            self.motorOilData = maintenenceData.1
            self.batteryData = maintenenceData.2
            self.marsPlugData = maintenenceData.3
            self.gearOilData = maintenenceData.4
        }
    }
}


