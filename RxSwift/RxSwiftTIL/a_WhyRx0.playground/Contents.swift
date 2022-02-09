import RxSwift

let disposeBag = DisposeBag()

// subject는 Observer이자 Observable
// onNext로 이벤트를 전달할 수도 있고
// 다른 Observer가 구독도 가능
let crossfitGames = PublishSubject<String>()

let athlete1 = crossfitGames.subscribe{ print("\($0.element!)이 공개되었어요 🏋🏻‍♀️athlete1님 화이팅!!")}
athlete1.disposed(by: disposeBag)

crossfitGames.onNext("22.1 WORKOUT 🏋🏻‍♀️")
crossfitGames.onNext("22.2 WORKOUT 🤸‍♀️")

let athlete2 = crossfitGames.subscribe{ print("\($0.element!)이 공개되었어요 🏋🏻‍♀️athlete2님 화이팅!!")}

crossfitGames.onNext("22.3 WORKOUT 📦🏃‍♀️")

/*
 output :
 22.1 WORKOUT 🏋🏻‍♀️이 공개되었어요 🏋🏻‍♀️athlete1님 화이팅!!
 22.2 WORKOUT 🤸‍♀️이 공개되었어요 🏋🏻‍♀️athlete1님 화이팅!!
 22.3 WORKOUT 📦🏃‍♀️이 공개되었어요 🏋🏻‍♀️athlete1님 화이팅!!
 22.3 WORKOUT 📦🏃‍♀️이 공개되었어요 🏋🏻‍♀️athlete2님 화이팅!!
 */
