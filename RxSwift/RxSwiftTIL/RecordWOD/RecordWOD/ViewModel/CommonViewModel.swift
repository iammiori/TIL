//
//  CommonViewModel.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/21.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel : NSObject {
    //navigation 에 임베드 되서, title필요
    // 쉽게 바인딩 가능
    let title : Driver<String>
    // scenecoordinator, 저장소 저장 속성
    let sceneCoordinator : SceneCoordinatorType
    let storage : RecordStorageType
    
    init(title : String, sceneCoordinator : SceneCoordinatorType, storage : RecordStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}
