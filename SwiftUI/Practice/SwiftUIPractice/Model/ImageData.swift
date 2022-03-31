//
//  ImageData.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/27.
//

import Foundation

struct ImageData : Identifiable {
    //MARK: Identifiable 프로토콜 채용
    //swiftUi가 개별 데이터 식별 가능해, forEach써서 열거가능
    var id : String {
        name
    }
    let name : String
    let filters : [String]
    let date : Date
    
    static var sample: ImageData {
        .init(name: "img1234.png", filters: ["Noir", "Monochrome"], date: Date.now.addingTimeInterval(TimeInterval.random(in: 1000 ... 100000) * -1))
    }
}
