import RxSwift

//MARK: BehaviorSubject
enum Err : Error {
    case err
}

let disposeBag = DisposeBag()

// PublishSubject와 달리, 생성시점에 event를 지정
let bs = BehaviorSubject<String>(value: "a")

bs.subscribe { print("observer1", $0) }
    .disposed(by: disposeBag)

bs.onNext("b")
bs.onNext("c")
bs.subscribe { print("observer2", $0) }
.disposed(by: disposeBag)
bs.onNext("d")
//bs.onCompleted()
bs.onError(Err.err)
bs.subscribe { print("observer3", $0) }
.disposed(by: disposeBag)
/*
 output:
 observer1 next(a)
 observer1 next(b)
 observer1 next(c)
 observer2 next(c)
 observer1 next(d)
 observer2 next(d)
 observer3 next(d)
 (if err)
 observer1 next(a)
 observer1 next(b)
 observer1 next(c)
 observer2 next(c)
 observer1 next(d)
 observer2 next(d)
 observer1 error(err)
 observer2 error(err)
 observer3 error(err)
 */
