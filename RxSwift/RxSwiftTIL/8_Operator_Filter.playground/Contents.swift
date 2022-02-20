import RxSwift

let disposeBag = DisposeBag()

let numArr : [Int] = [0,1,2,3,4,5]

//elementAt
Observable.from(numArr)
    .element(at: 3)
    .subscribe { print("elementAt : \($0)")}
    .disposed(by: disposeBag)

enum Field {
    case weightlifting, gymnastics, uncertain
}

struct Movement {
    let name : String
    let field : Field
}

var movements : [Movement] = []
movements.append(Movement(name: "handstand push up", field: .gymnastics))
movements.append(Movement(name: "toes to bar", field: .gymnastics))
movements.append(Movement(name: "power clean", field: .weightlifting))
movements.append(Movement(name: "hang squat snatch", field: .weightlifting))
movements.append(Movement(name: "box jump over", field: .uncertain))

// gymnastic 동작만 꺼내기
Observable.from(movements)
    .filter { $0.field == .gymnastics }
    .subscribe { print("🤸‍♀️gymnastics 동작은 \($0)") }
    .disposed(by: disposeBag)

// Skip
Observable.from(movements)
    .skip(1)
    .subscribe { print("skip 해버리기 : \($0)")}
    .disposed(by: disposeBag)
// output : toes to bar 부터 출력


Observable.from(movements)
    .skip(while: { $0.field != .weightlifting })
    .subscribe { print("weightlifting 부터 출력해버리기 \($0)")}
    .disposed(by: disposeBag)

let triggerObservable = PublishSubject<Movement>()
let movementObservable = PublishSubject<Movement>()

movementObservable
    .skip(until: triggerObservable)
    .subscribe { print("trigger 이후부터 방출 :\($0)")}
    .disposed(by: disposeBag)
movementObservable.onNext(Movement(name: "box jump over", field: .uncertain))
triggerObservable.onNext(Movement(name: "handstand walk", field: .gymnastics))
movementObservable.onNext(Movement(name: "handstand push up", field: .gymnastics))
