//
//  BoxOfficeModel.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/03/02.
//

import Foundation

struct BoxOfficeModel {
    func goFilter(type : Int, data : [BoxOfficeList]) -> [BoxOfficeList] {
        if type == 0 {
            return data
        } else {
            return data.filter {
                $0.rankOldAndNew == "NEW"
            }
        }
    }
}
