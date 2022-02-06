import RxSwift

let disposeBag = DisposeBag()

// 이벤트는 이렇게 전달되어야함! 이라고 정의
Observable<String>.create { (observer) -> Disposable in
    observer.onNext("a")
    observer.on(.next("b"))
    observer.onCompleted()
    
    return Disposables.create()
}

// 배열에 있는 요소를 하나씩 방출
Observable.from(["a","b"])
    // 구독해야 이벤트가 전달이 됨
    .subscribe { print($0) }
    .disposed(by: disposeBag)
