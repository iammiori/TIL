import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let pl = PublishRelay<String>()
pl.subscribe { print("PublishRelay o1 : \($0)")}
.disposed(by: disposeBag)

pl.accept("a")

let bl = BehaviorRelay<String>(value: "a")
bl.accept("b")
bl.subscribe { print("BehaviorRelay o1 : \($0)")}
.disposed(by: disposeBag)
print("BehaviorRelay는 value를 통해 값도 꺼낼수 있다구 : \(bl.value)")

let arr : [String] = ["a","b","c","d","e"]
let rl = ReplayRelay<String>.create(bufferSize: 3)
arr.forEach { rl.accept($0) }
rl.subscribe { print("ReplayRelay o1 : \($0)")}
.disposed(by: disposeBag)

