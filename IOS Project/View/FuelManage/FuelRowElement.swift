//
//  FuelRowElement.swift
//  IOS Project
//
//  Created by Xiao-Allen on 2020/6/28.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import SwiftUI

struct FuelRowElement: View{
    let fuelConsume: FuelConsumeViewModel
    static let releaseFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .long
        formatter.dateFormat = "yyyy\nMM/dd"
      return formatter
    }()
    var body: some View{
        HStack {
            HStack{
               VStack(alignment:.trailing){
                    Text(Self.releaseFormatter.string(from: fuelConsume.date))
                }
                Text(fuelConsume.name)
            }.frame(maxWidth: .infinity,alignment: .leading)
            HStack{
                
                VStack(alignment: .trailing){
                    Text("當前里程數:" + "\(fuelConsume.milage)" + "Km")
                    Text("花費:" + "$" + "\(fuelConsume.cost)")
                    Text("加了" + "\(fuelConsume.fuelCapacity)" + "公升")
                }
            }
        }.frame(maxWidth: .infinity)
    }
}
