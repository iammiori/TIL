import RxSwift

//MARK: PublishSubject
enum Err : Error {
    case err
}
let disposeBag = DisposeBag()
let ps = PublishSubject<String>()
ps.onNext("a") //아직 구독전이라 아무 일도 안일어남

// 구독
ps.subscribe { print("observer1", $0)}
.disposed(by: disposeBag)
// 출력이 안됨
// 이유 : publishSubject 는 구독이후 전달되는 event만 전달이 됨

// 새로운 이벤트 방출
ps.onNext("b")
ps.onNext("c")
// 또 다른 구독자
ps.subscribe { print("observer2", $0)}
.disposed(by: disposeBag)
ps.onNext("d")
//ps.onCompleted()
//ps.onError(Err.err)
ps.subscribe { print("observer3", $0)}
.disposed(by: disposeBag)

/*
 output :
 observer1 next(b)
 observer1 next(c)
 observer1 next(d)
 observer2 next(d)
 */
// onCompleted이나 onError가 방출되면 completed/err을 전달하고 흐름 종료
