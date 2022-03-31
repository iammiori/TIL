//
//  SportsData.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/28.
//

import Foundation

struct SportsData : Identifiable {
    var id : String {
        return movementName
    }
    let movementName : String
    let movementIdx : Int
    
    static let samples : [SportsData] = [
        SportsData(movementName: "스내치", movementIdx: 0),
        SportsData(movementName: "물구나무", movementIdx: 1),
        SportsData(movementName: "복싱", movementIdx: 2),
        SportsData(movementName: "펜싱", movementIdx: 3)
    ]
}
