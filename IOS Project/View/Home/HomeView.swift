//
//  HomeView.swift
//  IOS Project
//
//  Created by KaiHuang on 2020/6/14.
//  Copyright © 2020 KaiHuang. All rights reserved.
//

import Foundation
import SwiftUI

struct HView: PreviewProvider {
    static var previews: some View {
        HomeView().frame(maxHeight: UIScreen.main.bounds.height, alignment: .top)
    }
}

struct HomeView: View {
    var body: some View {
        VStack{
            
            ZStack{
                Text("首頁").font(.title).frame(alignment:.center)
            }.frame(maxWidth: .infinity)
            Divider()
            BikeInfo().frame(maxWidth: .infinity, alignment: .top)
            Divider().padding(.vertical, 5.0)
            TodayOilPrice().frame(maxWidth: .infinity, alignment: .topLeading)
        }.frame(maxWidth: UIScreen.main.bounds.width-40)
    }
}

struct BikeInfo: View {
    @State private var ImageHeight:CGFloat = 150
    @State private var ImageWidth:CGFloat = 150
    @State private var bikeInfoData: BikeInfoData = BikeInfoData(bikeNo: "未設定",bikeBrand: "未設定",bikeCc: "0",bikeIssueDate: "19000101")
    
    
    @State private var showAlert = false
    
    private func alert() {
        let alert = UIAlertController(title: "設定機車車牌", message: "", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "機車車牌"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in })
        alert.addAction(UIAlertAction(title: "Done", style: .default) {
            (action) in
            let bikeNo = alert.textFields?[0].text ?? "000"
            let loadBikeInfo: LoadBikeInfo = LoadBikeInfo(bikeNo: bikeNo)
            loadBikeInfo.exec()
            self.bikeInfoData = loadBikeInfo.getBikeInfoData()
        })
        showAlert(alert: alert)
    }

    func showAlert(alert: UIAlertController) {
        if let controller = topMostViewController() {
            controller.present(alert, animated: true)
        }
    }

    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
        .filter {$0.activationState == .foregroundActive}
        .compactMap {$0 as? UIWindowScene}
        .first?.windows.filter {$0.isKeyWindow}.first
    }

    private func topMostViewController() -> UIViewController? {
        guard let rootController = keyWindow()?.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootController)
    }

    private func topMostViewController(for controller: UIViewController) -> UIViewController {
        if let presentedController = controller.presentedViewController {
            return topMostViewController(for: presentedController)
        } else if let navigationController = controller as? UINavigationController {
            guard let topController = navigationController.topViewController else {
                return navigationController
            }
            return topMostViewController(for: topController)
        } else if let tabController = controller as? UITabBarController {
            guard let topController = tabController.selectedViewController else {
                return tabController
            }
            return topMostViewController(for: topController)
        }
        return controller
    }
    
    var body: some View{
        VStack {
            HStack{
                Image("default").resizable().padding(.horizontal, 0.0).scaledToFit().frame(width: ImageWidth,height: ImageHeight, alignment: .leading)
                VStack(alignment: .leading){
                    Text("機車牌照： " + self.bikeInfoData.bikeNo).padding(.bottom, 20)
                    Text("機車品牌： " + self.bikeInfoData.bikeBrand).padding(.bottom, 20)
                    Text("排氣量： " + self.bikeInfoData.bikeCc + " cc").padding(.bottom, 20)
                    Text("發照日： " + self.bikeInfoData.bikeIssueDate)
                }.frame(maxWidth: .infinity)
                .padding(14.0)
            }
            Button(action: {
                self.alert()
            }) {
                Text("設定")
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct TodayOilPrice: View{
    @State var loadFuelInfo: LoadFuelInfo = LoadFuelInfo()
    @State var flueInfo: FuelInfoData = FuelInfoData(upOrDown: "調漲", upOrDownPrice: "0.0", fuel92: "0.0", fuel95: "0.0", fuel98: "0.0")
    
    var body: some View{
        VStack(alignment: .leading){
            Text("今日汽油零售價格")
                .font(.title).multilineTextAlignment(.center).padding(.vertical, 5.0).frame(maxWidth:.infinity, alignment: .leading)
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/20.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.red)
                HStack{
                    Text("本週汽油價格")
                        .fontWeight(.bold)
                    Text(flueInfo.upOrDown + flueInfo.upOrDownPrice).font(.title).fontWeight(.heavy)
                }.foregroundColor(Color.white)
            }
            .frame(height: UIScreen.main.bounds.height/15)
            .padding(.vertical, 5.0)
            VStack(alignment: .leading){
                HStack{
                    Text("92無鉛汽油：").font(.headline)
                    Text(flueInfo.fuel92).font(.headline).foregroundColor(Color.red)
                }.padding(.vertical, 20)
                HStack{
                    Text("95無鉛汽油：").font(.headline)
                    Text(flueInfo.fuel95).font(.headline).foregroundColor(Color.red)
                    
                }.padding(.vertical, 20)
                HStack{
                    Text("95無鉛汽油：").font(.headline)
                    Text(flueInfo.fuel98).font(.headline).foregroundColor(Color.red)
                }.padding(.vertical, 20)
            }
        }.frame(maxWidth: .infinity).onAppear(){
            self.loadFuelInfo.exec()
            self.flueInfo = self.loadFuelInfo.getFuelInfo()
        }
    }
}
