//
//  FuelInfo.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/27.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
class FuelInfoData{
    var upOrDown: String
    var upOrDownPrice: String
    var fuel92: String
    var fuel95: String
    var fuel98: String
    
    init(upOrDown: String, upOrDownPrice: String, fuel92: String, fuel95: String, fuel98: String){
        self.upOrDown = upOrDown
        self.upOrDownPrice = upOrDownPrice
        self.fuel92 = fuel92
        self.fuel95 = fuel95
        self.fuel98 = fuel98
    }
}
