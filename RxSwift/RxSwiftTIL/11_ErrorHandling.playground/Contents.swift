import RxSwift

enum Err : Error {
    case err
}

let disposeBag = DisposeBag()

let source = PublishSubject<Int>()
let recovery = PublishSubject<Int>()

source
    .catch { _ in recovery }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

source.onError(Err.err)

recovery.onNext(1)
