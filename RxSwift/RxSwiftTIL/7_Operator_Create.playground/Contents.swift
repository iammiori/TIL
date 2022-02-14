import RxSwift

enum Err : Error {
    case error
}

let disposeBag = DisposeBag()
// Observable 생성과 구독
//MARK: Create
Observable<String>.create { observer in
    observer.onNext("🏋🏻‍♀️")
    observer.onCompleted()
    //observer.onError(Err.error)
    return Disposables.create()
}.subscribe(
    onNext: { print("Next",$0) },
    onError: { print("Error",$0) },
    onCompleted: { print("Completed") },
    onDisposed: { print("Disposed") }
).disposed(by: disposeBag)

//MARK: Range
Observable.range(start: 0, count: 5)
    .subscribe { print("range : \($0)")}
    .disposed(by: disposeBag)

//MARK: generate
Observable.generate(initialState: 5, condition: { $0 >= 0 }, iterate: { $0 - 2 })
    .subscribe { print("generate : \($0)")}
    .disposed(by: disposeBag)

//MARK: Repeat
Observable.repeatElement(0)
    .take(3)
    .subscribe{ print("repeat : \($0)")}
    .disposed(by: disposeBag)

var flag : Bool = false
var cnt : Int = 0
let factory : Observable<Int> = Observable.deferred {
    flag.toggle()
    cnt += 1
    if flag {
        return Observable.from([1,3,5])
    } else {
        return Observable.from([2,4,6])
    }
}

factory.subscribe { print("deferred toggle \(cnt) : \($0)") }
.disposed(by: disposeBag)

factory.subscribe { print("deferred toggle \(cnt) : \($0)") }
.disposed(by: disposeBag)
