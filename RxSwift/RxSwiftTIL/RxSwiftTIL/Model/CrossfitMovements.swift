//
//  CrossfitMovements.swift
//  RxSwiftTIL
//
//  Created by miori Lee on 2022/02/23.
//

import Foundation

enum Category : String {
    case girlsName = "Girl's Name"
    case hero = "Hero"
}
struct CrossfitMovements {
    let category : Category
    let name : String
    let movements : String
    let level : String
}
