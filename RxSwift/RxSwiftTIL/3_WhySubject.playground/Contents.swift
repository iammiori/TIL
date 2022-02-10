import RxSwift

let disposeBag = DisposeBag()

func checkEmail(email : String) -> Bool{
    return email.contains("@")
}

//MARK: Observable
Observable.just("immioriii@gmail.com")
    .subscribe { print(checkEmail(email: $0))}
    .disposed(by: disposeBag)

print("---")

//MARK: BehaviorSubject
let bs = BehaviorSubject<String>(value: "")

bs.subscribe { print(checkEmail(email: $0))}
.disposed(by: disposeBag)

bs.onNext("ii")
bs.onNext("iii")
bs.onNext("iii@")
bs.onNext("iii@g")
