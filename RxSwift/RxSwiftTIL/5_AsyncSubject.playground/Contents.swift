import RxSwift

enum Err : Error {
    case err
}

let disposeBag = DisposeBag()
  
let arr : [String] = ["a","b","c"]
let asyncS = AsyncSubject<String>()

arr.forEach { asyncS.onNext($0) }

asyncS.subscribe { print("o1 : \($0)")}

//asyncS.onCompleted() //1
asyncS.onError(Err.err) //2
//print("completed되지 않으면 어떠한 event도 전달안됨") //3
asyncS.subscribe { print("o2 : \($0)")}

