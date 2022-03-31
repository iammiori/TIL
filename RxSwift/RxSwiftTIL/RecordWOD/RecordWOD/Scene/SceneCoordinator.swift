//
//  SceneCoordinator.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/21.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator : SceneCoordinatorType {
    // 리소스 정리
    private let bag = DisposeBag()
    // 화면 전환을 처리하므로 window instance와 현재 화면에 표시되어있는 scene 갖고있어야함
    private var window : UIWindow
    private var currentVC  : UIViewController
    
    required init(window : UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        // 화면전환 결과를 방출할 subject : 성공/ 실패만 방출 -> element type을 never로
        let subject = PublishSubject<Never>()
        let target = scene.instantiate()
        switch style {
        case .root:
            currentVC = target
            window.rootViewController = target
            
            subject.onCompleted()
        case .push:
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            nav.pushViewController(target, animated: animated)
            currentVC = target
            subject.onCompleted()
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target
        }
        return subject.asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransitionError.unknow))
            }
            return Disposables.create()
        }
    }
    
    
}
