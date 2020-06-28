//
//  ExtensionString.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/27.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation

extension String {
    subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }

    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }
    
    func subStr(startIndex: Int, endIndex: Int) -> Substring {
        return self[startIndex..<endIndex]
    }
    
    func subStrWithRegex(regex: String) -> [String]{
        return self.match(for: regex, in: self)
    }
    
    private func match(for regex: String, in text: String) -> [String] {
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
