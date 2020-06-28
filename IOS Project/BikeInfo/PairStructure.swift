//
//  PairStructure.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/28.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation

class PairStructure{
    var key: String
    var value: String
    
    init(key: String, value: String){
        self.key = key
        self.value = value
    }
    
    func getUrlQueryText() -> String{
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: "-._~")
        let escapedKey = key.addingPercentEncoding(withAllowedCharacters: allowed) ?? ""
        let escapedValue = value.addingPercentEncoding(withAllowedCharacters: allowed) ?? ""
        return (escapedKey + "=" + escapedValue)
    }
    
}
