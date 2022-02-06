import RxSwift

let disposeBag = DisposeBag()

Observable<String>.create { (observer) -> Disposable in
    observer.onNext("a")
    observer.on(.next("b"))
    observer.onCompleted()
    return Disposables.create()
}

//from : 배열에 저장된 요소를 하나씩 방출
Observable.from(["a","b"])
    .subscribe { print($0) }
    .disposed(by: disposeBag)
