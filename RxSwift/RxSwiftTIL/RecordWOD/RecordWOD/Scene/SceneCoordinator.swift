//
//  SceneCoordinator.swift
//  RecordWOD
//
//  Created by miori Lee on 2022/03/21.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: SceneCoordinator 구현시 주의해야할점
/*
 - viewController 를 임베드 하고 있는 컨트롤러 (ex navi) 가 아니라, 실제로 화면에 표시되어 있는 뷰 컨트롤러 기준으로 전환 처리
 */

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
            currentVC = target.sceneViewController
            window.rootViewController = target
            
            subject.onCompleted()
        case .push:
            print(currentVC)
            //guard 문에 breakpoint
            //step over 시 error문 으로 이동
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            
            nav.rx.willShow
                .withUnretained(self)
                .subscribe(onNext: { (coordinator, evt) in
                    coordinator.currentVC = evt.viewController.sceneViewController
                })
                .disposed(by: bag)
            
            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController
            subject.onCompleted()
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target.sceneViewController
        }
        return subject.asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!.sceneViewController
                completable(.completed)
            } else {
                completable(.error(TransitionError.unknow))
            }
            return Disposables.create()
        }
    }
    
    
}
