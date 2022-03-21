//
//  TransitionModel.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/21.
//

import Foundation

//MARK: 전환방식을 표현하는 enum
enum TransitionStyle {
    case root
    case push
    case modal
}

//MARK: 전환시 발생할 수 있는 error
enum TransitionError : Error {
    case navigationControllerMissing
    case cannotPop
    case unknow
}
