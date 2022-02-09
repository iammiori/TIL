import RxSwift

let disposeBag = DisposeBag()

// subject는 Observer이자 Observable
// onNext로 이벤트를 전달할 수도 있고
// 다른 Observer가 구독도 가능
let crossfitGames = PublishSubject<String>()

func announce(eventWOD : String, athlete: String) {
    if !eventWOD.isEmpty {
    print("\(eventWOD)이 공개되었어요 \(athlete)님 화이팅!!")
    }
}

let athlete1 = crossfitGames.subscribe(
    onNext: { announce(eventWOD: $0, athlete: "athlete1") },
    onError: nil,
    onCompleted: { print("🏋🏻‍♀️athlete1님, 수고하셨습니다👏 모든 이벤트가 종료되었습니다") },
    onDisposed: nil)
athlete1.disposed(by: disposeBag)

crossfitGames.onNext("22.1 WORKOUT 🏋🏻‍♀️")
crossfitGames.onNext("22.2 WORKOUT 🤸‍♀️")

let athlete2 = crossfitGames.subscribe(
    onNext: { announce(eventWOD: $0, athlete: "athlete2") },
    onError: nil,
    onCompleted: { print("🏋🏻‍♀️athlete2님, 수고하셨습니다👏 모든 이벤트가 종료되었습니다") },
    onDisposed: nil)
athlete2.disposed(by: disposeBag)

crossfitGames.onNext("22.3 WORKOUT 📦🏃‍♀️")

crossfitGames.onCompleted()
/*
 output :
 22.1 WORKOUT 🏋🏻‍♀️이 공개되었어요 🏋🏻‍♀️athlete1님 화이팅!!
 22.2 WORKOUT 🤸‍♀️이 공개되었어요 🏋🏻‍♀️athlete1님 화이팅!!
 22.3 WORKOUT 📦🏃‍♀️이 공개되었어요 🏋🏻‍♀️athlete1님 화이팅!!
 22.3 WORKOUT 📦🏃‍♀️이 공개되었어요 🏋🏻‍♀️athlete2님 화이팅!!
 🏋🏻‍♀️athlete1님, 수고하셨습니다👏 모든 이벤트가 종료되었습니다
 🏋🏻‍♀️athlete2님, 수고하셨습니다👏 모든 이벤트가 종료되었습니다
 */
