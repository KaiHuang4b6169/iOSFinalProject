//
//  BikeInfo.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/28.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation

class LoadBikeInfo{
    let urlString: String = "https://www.motorim.org.tw/query/Query_Check.aspx"
    var postData: Array<PairStructure>
    var bikeNo: String
    var bikeInfo: BikeInfoData
    var isLoadDone = false
    
    init(bikeNo: String){
        self.postData = Array()
        self.bikeNo = bikeNo
        self.bikeInfo = BikeInfoData(bikeNo: "",bikeBrand: "",bikeCc: "",bikeIssueDate: "")
    }
    
    func exec(){
        self.loadMainPage(postData: postData)
        self.setBikeNoToPostData()
        self.loadBikeDetailInfo(postDataTxt: self.getPostDataString())
    }
    
    func getBikeInfoData() -> BikeInfoData{
        while(!self.isLoadDone){
            
        }
        return self.bikeInfo
    }
    
    private func loadMainPage(postData: Array<PairStructure>){
        let viewState: String = "__VIEWSTATE"
        let viewStateGenerator: String = "__VIEWSTATEGENERATOR"
        let eventValidation: String = "__EVENTVALIDATION"
        
        if let url = URL(string: self.urlString){
            if let data = try? Data(contentsOf: url){
                let htmlDocument = String(decoding: data, as: UTF8.self)
                self.postData.append(PairStructure(key: viewState, value: self.getMotorimFormHiddenValue(html: htmlDocument, id: viewState)))
                self.postData.append(PairStructure(key: viewStateGenerator, value: self.getMotorimFormHiddenValue(html: htmlDocument, id: viewStateGenerator)))
                self.postData.append(PairStructure(key: eventValidation, value: self.getMotorimFormHiddenValue(html: htmlDocument, id: eventValidation)))
            }
        }
    }
    
    private func loadBikeDetailInfo(postDataTxt: String){
        if let url = URL(string: self.urlString){
            var request : URLRequest = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = postDataTxt.data(using: .ascii)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                (data, response, error) in
                let datas = data
                var htmlDocument = String(bytes: datas!, encoding: .utf8)!
                var bikeNo: String = self.getMotorimBikeInfoValue(html: htmlDocument, id: "ctl00_MainContent_lblCarNo") ?? "未設定"
                var bikeBrand: String = self.getMotorimBikeInfoValue(html: htmlDocument, id: "ctl00_MainContent_lblBrandName") ?? "未設定"
                var bikeCc: String = self.getMotorimBikeInfoValue(html: htmlDocument, id: "ctl00_MainContent_lblCc") ?? "0"
                var bikeIssueDate: String = self.getMotorimBikeInfoValue(html: htmlDocument, id: "ctl00_MainContent_lblIssueDt") ?? "19000101"
                self.bikeInfo = BikeInfoData(bikeNo: bikeNo,bikeBrand: bikeBrand,bikeCc: bikeCc,bikeIssueDate: bikeIssueDate)
                self.isLoadDone = true
            }.resume()
        }
    }
    
    private func getMotorimFormHiddenValue(html: String, id: String) -> String {
        let begingString = "id=\"" + id + "\" value=\""
        let endString = "\" /"
        
        let tag: String = html.subStrWithRegex(regex: begingString + ".*" + endString)[0]
        return String(tag.subStr(startIndex: begingString.count, endIndex: tag.count - endString.count))
    }
    
    private func getMotorimBikeInfoValue(html: String, id: String) -> String! {
        let begingString = "<span id=\"" + id + "\">"
        let endString = "</span>"
        let subStrings = html.subStrWithRegex(regex: begingString + ".*" + endString)
        if (subStrings.count == 0) {return nil}
        
        let tag: String = subStrings[0]
        return String(tag.subStr(startIndex: begingString.count, endIndex: tag.count - endString.count))
    }
    
    private func setBikeNoToPostData(){
        self.postData.append(PairStructure(key: "ctl00$MainContent$txtCarNo", value: self.bikeNo))
        self.postData.append(PairStructure(key: "ctl00$MainContent$btnQuery", value: "查詢"))
        
    }
    
    private func getPostDataString() -> String{
        var postDataStr: String = ""

        for data in self.postData{
            postDataStr += (postDataStr=="" ? "" : "&") + data.getUrlQueryText()
        }
        return postDataStr
    }
}
