import RxSwift

let disposeBag = DisposeBag()

func checkVaild(_ email : String) -> Bool {
    return email.contains("@")
}

Observable.just("immioriii@gmail.com")
    .map { checkVaild($0) }
    .subscribe { print("\($0)")}
    .disposed(by: disposeBag)


