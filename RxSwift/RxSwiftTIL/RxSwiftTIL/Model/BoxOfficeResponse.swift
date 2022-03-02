//
//  BoxOfficeResponse.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/27.
//

import Foundation

struct BoxOfficeResponse : Decodable {
    let boxOfficeResult : BoxOfficeDetail
}

struct BoxOfficeDetail : Decodable {
    let dailyBoxOfficeList : [BoxOfficeList]
}

struct BoxOfficeList : Decodable {
    let movieNm : String
    let rankOldAndNew : String
}

