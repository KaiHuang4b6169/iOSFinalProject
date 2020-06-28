//
//  LoadFuelInfo.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/26.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation

class LoadFuelInfo {
    private var fuelInfo: FuelInfoData? = nil
    
    init(){
    }
    
    func exec(){
        var urlString = "https://www.cpc.com.tw/GetOilPriceJson.aspx?type=TodayOilPriceString"
        if let url = URL(string: urlString){
            let decoder = JSONDecoder()
            if let data = try? Data(contentsOf: url), let fuelInfoCodable = try?decoder.decode(FuelInfoCodable.self, from: data){
                self.codableToEntity(codable: fuelInfoCodable)
            }
        }
    }
    
    func getFuelInfo()->FuelInfoData{
        return self.fuelInfo ?? FuelInfoData(upOrDown: "上漲", upOrDownPrice: "0.0", fuel92: "0.0", fuel95: "0.0", fuel98: "0.0")
    }
    
    func codableToEntity(codable: FuelInfoCodable){
        var fuel92 = codable.sPrice1
        var fuel95 = codable.sPrice2
        var fuel98 = codable.sPrice3
        var upOrDown = self.getUpOrDownState(upOrDown_Html: codable.UpOrDown_Html)
        var upOrDownPrice = self.getUpOrDownPrice(upOrDown_Html: codable.UpOrDown_Html)
        
        self.fuelInfo = FuelInfoData(upOrDown: upOrDown, upOrDownPrice: upOrDownPrice, fuel92: fuel92, fuel95: fuel95, fuel98: fuel98)
    }
    
    func getUpOrDownState(upOrDown_Html: String)->String{
        var upOrDownTag: String = upOrDown_Html.subStrWithRegex(regex: "<b class=\"sys\">[^0-9]*</b>")[0]

        return String(upOrDownTag.subStr(startIndex: "<b class=\"sys\">".count, endIndex: upOrDownTag.count - "</b>".count))
    }
    
    func getUpOrDownPrice(upOrDown_Html: String)->String{
        var upOrDownTag: String = upOrDown_Html.subStrWithRegex(regex: "<i>.*</i>")[0]

        return String(upOrDownTag.subStr(startIndex: "<i>".count, endIndex: upOrDownTag.count - "</i>".count))
    }
    
    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
