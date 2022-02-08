import RxSwift

let disposeBag = DisposeBag()

enum Err : Error {
    case error
}

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

/*
 output :
 next(a)
 next(b)
 completed
 */

// Observable 생성과 구독
Observable<String>.create { observer in
    observer.onNext("🏋🏻‍♀️")
    //observer.onCompleted()
    observer.onError(Err.error)
    return Disposables.create()
}.subscribe(
    onNext: { print("Next",$0) },
    onError: { print("Error",$0) },
    onCompleted: { print("Completed") },
    onDisposed: { print("Disposed") }
).disposed(by: disposeBag)

/*
 output :
 (case onComplete)
 Next 🏋🏻‍♀️
 Completed
 Disposed
 (case onError)
 Next 🏋🏻‍♀️
 Error error
 Disposed
 */
