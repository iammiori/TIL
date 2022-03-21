//
//  SceneCoordinatorType.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/21.
//

import Foundation
import RxSwift

//MARK: protocol 선언, SceneCoordinator 가 공통적으로 구현해야하는 멤버
protocol SceneCoordinatorType {
    /*
     - @discardableResult : 이런 작업 필요없다면 사용안해도됨
     - Completable : 구독자 추가후, 화면전환 완료 후 원하는 작업 구현 가능
     */
    @discardableResult
    func transition(to scene : Scene , using style : TransitionStyle, animated : Bool) -> Completable
    
    @discardableResult
    func close(animated : Bool) -> Completable
}
