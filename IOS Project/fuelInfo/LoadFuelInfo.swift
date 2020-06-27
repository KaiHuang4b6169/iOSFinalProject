//
//  LoadFuelInfo.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/26.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation

class LoadFuelInfo {
    private var fuelInfo: FuelInfo? = nil
    
    init(){
    }
    
    func exec(){
        var urlString = "https://www.cpc.com.tw/GetOilPriceJson.aspx?type=TodayOilPriceString"
        if let url = URL(string: urlString){
//            URLSession.shared.dataTask(with: url){
//                (data, response, error) in
//                let decoder = JSONDecoder()
//                if let data = data, let fuelInfoCodable = try?decoder.decode(FuelInfoCodable.self, from: data){
//                    self.codableToEntity(codable: fuelInfoCodable)
//                }
//            }.resume()

            let decoder = JSONDecoder()
            if let data = try? Data(contentsOf: url), let fuelInfoCodable = try?decoder.decode(FuelInfoCodable.self, from: data){
                self.codableToEntity(codable: fuelInfoCodable)
            }
        }
    }
    
    func getFuelInfo()->FuelInfo{
        return self.fuelInfo ?? FuelInfo(upOrDown: "上漲", upOrDownPrice: "0.0", fuel92: "0.0", fuel95: "0.0", fuel98: "0.0")
    }
    
    func codableToEntity(codable: FuelInfoCodable){
        var fuel92 = codable.sPrice1
        var fuel95 = codable.sPrice2
        var fuel98 = codable.sPrice3
        var upOrDown = self.getUpOrDownState(UpOrDown_Html: codable.UpOrDown_Html)
        var upOrDownPrice = self.getUpOrDownPrice(UpOrDown_Html: codable.UpOrDown_Html)
        
        self.fuelInfo = FuelInfo(upOrDown: upOrDown, upOrDownPrice: upOrDownPrice, fuel92: fuel92, fuel95: fuel95, fuel98: fuel98)
    }
    
    func getUpOrDownState(UpOrDown_Html: String)->String{
        var upOrDownTag: String = matches(for: "<b class=\"sys\">[^0-9]*</b>", in: UpOrDown_Html)[0]

        var startIndx = upOrDownTag.index("<b class=\"sys\">".endIndex, offsetBy: 0)
        var begingIndx = upOrDownTag.index(upOrDownTag.endIndex, offsetBy: -1 * "</b>".count)

        return String(upOrDownTag[startIndx..<begingIndx])
    }
    
    func getUpOrDownPrice(UpOrDown_Html: String)->String{
        var upOrDownTag: String = matches(for: "<i>.*</i>", in: UpOrDown_Html)[0]

        var startIndx = upOrDownTag.index("<i>".endIndex, offsetBy: 0)
        var begingIndx = upOrDownTag.index(upOrDownTag.endIndex, offsetBy: -1 * "</i>".count)

        return String(upOrDownTag[startIndx..<begingIndx])
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
