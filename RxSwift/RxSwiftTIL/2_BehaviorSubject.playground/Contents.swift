import RxSwift

//MARK: BehaviorSubject
enum Err : Error {
    case error
}

let disposeBag = DisposeBag()

// PublishSubject와 달리, 생성시점에 event를 지정
let bs = BehaviorSubject<String>(value: "a")

bs.subscribe { print("observer1", $0) }
    .disposed(by: disposeBag)
// output : observer1 next(a)
bs.onNext("b")
// output : observer1 next(b)

