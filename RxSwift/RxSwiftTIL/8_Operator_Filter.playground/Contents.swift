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
