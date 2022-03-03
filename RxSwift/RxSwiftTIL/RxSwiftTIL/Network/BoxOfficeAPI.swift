//
//  BoxOfficeAPI.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/27.
//

import Foundation

struct BoxOfficeAPI {
    static let scheme = "https"
    static let host = "kobis.or.kr"
    static let path = "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    
    func getBoxOffice() -> URLComponents {
        var components = URLComponents()
        components.scheme = BoxOfficeAPI.scheme
        components.host = BoxOfficeAPI.host
        components.path = BoxOfficeAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "key", value: Secret.openAPIKEY),
        URLQueryItem(name: "targetDt", value: "20220302")
        ]
        return components
    }
}
