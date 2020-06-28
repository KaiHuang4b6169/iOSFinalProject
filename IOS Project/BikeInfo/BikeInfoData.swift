//
//  BikeInfo.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/28.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
class BikeInfoData{
    var bikeNo: String
    var bikeBrand: String
    var bikeCc: String
    var bikeIssueDate: String
    init(bikeNo: String, bikeBrand: String, bikeCc: String, bikeIssueDate: String){
        self.bikeNo = bikeNo
        self.bikeBrand = bikeBrand
        self.bikeCc = bikeCc
        self.bikeIssueDate = bikeIssueDate
    }
}
