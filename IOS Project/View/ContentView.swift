//
//  ContentView.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/12.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首頁")
                }
                .tag(1)
            MaintenanceManage()
                .frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
                .tabItem {
                    Image(systemName: "wrench.fill")
                    Text("保養管理")
                }
                .tag(2)
            FuelManage()
                .frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("油耗管理")
                }
                .tag(3)
            BikeReportView()
                .frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
                .tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("機車報告")
                }
                .tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
    }
}
