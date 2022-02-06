import RxSwift

//MARK: PublishSubject
enum Err : Error {
    case error
}
let ps = PublishSubject<String>()
ps.onNext("a") //아직 구독전이라 아무 일도 안일어남

// 구독
ps.subscribe { print("observer1", $0)}
// 출력이 안됨
// 이유 : publishSubject 는 구독이후 전달되는 event만 전달이 됨

// 새로운 이벤트 방출
ps.onNext("b")

// 또 다른 구독자
ps.subscribe { print("observer2", $0)}
ps.onNext("c")
//ps.onCompleted()
//ps.onError(Err.error)
ps.subscribe { print("observer3", $0)}
