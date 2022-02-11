import RxSwift

//MARK: ReplaySubject
enum Err : Error {
    case err
}

let disposeBag = DisposeBag()

let arr : [String] = ["a","b","c","d","e"]
let rs = ReplaySubject<String>.create(bufferSize: 3)
arr.forEach { rs.onNext($0)}
rs.subscribe { print("o1 : \($0)")}
//rs.onNext("f")
rs.onError(Err.err)
rs.subscribe { print("o2 : \($0)") }
.disposed(by: disposeBag)
/*
 output :
 o1 : next(c)
 o1 : next(d)
 o1 : next(e)
 o1 : error(err)
 o2 : next(c)
 o2 : next(d)
 o2 : next(e)
 o2 : error(err)
 */
