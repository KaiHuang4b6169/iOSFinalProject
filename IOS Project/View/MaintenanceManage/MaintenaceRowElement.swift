//
//  MaintenaceRowElement.swift
//  IOS Project
//
//  Created by Xiao-Allen on 2020/6/25.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import SwiftUI

struct MaintenaceRowElement: View{
    
    let maintenance: MaintenanceViewModel
    static let releaseFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    var body: some View{
        HStack {
            HStack{
                VStack(alignment:.trailing){
                    Text(Self.releaseFormatter.string(from: maintenance.date))
                    .font(.caption)
                }
                Image(maintenance.imageName).resizable().padding(.horizontal, 0.0).scaledToFit().frame(width: 75,height: 75)
                Text(maintenance.name).font(.caption)
            }.frame(maxWidth: .infinity,alignment: .leading)
            VStack{
                Text("花費:" + "$" + "\(maintenance.cost)")
                Text("當前里程數:" + "\(maintenance.milage)" + "Km")
            }.frame(alignment: .trailing)
        }.frame(maxWidth: .infinity)
        .onTapGesture {
            print("\(self.maintenance.cost)")
        }
    }
}
