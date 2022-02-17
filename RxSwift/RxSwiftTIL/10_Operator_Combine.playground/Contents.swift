import RxSwift

let disposeBag = DisposeBag()

let arr : [Int] = [1,2,3]

Observable.from(arr)
    .startWith(0)
    .subscribe { print("startWith : \($0)")}
    .disposed(by: disposeBag)

Observable.from(arr)
    .startWith(-2,-1,0)
    .startWith(-3)
    .subscribe { print("startWith 2 : \($0)")}
    .disposed(by: disposeBag)
