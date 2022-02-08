//MARK: ObserverPattern

// 구독자
protocol Observer {
    var name : String { get set }
    var crossfitGames : CrossfitGames { get }
    func upload()
}

// 발행자
protocol Subject {
    var observers : [Observer] { get }
    var workouts : String { get set }
    func subscribe(observer : Observer)
    func announce()
}

// 크로스핏 게임즈는 오픈와드를 발행
class CrossfitGames : Subject {
    var observers: [Observer] = []
    var _workouts : String = ""
    init(observers : [Observer], _workouts : String) {
        self.observers = observers
        self._workouts = _workouts
    }
    var workouts: String {
        get {
            return _workouts
        }
        set {
            _workouts = newValue
            announce()
        }
    }
    func subscribe(observer: Observer) {
        observers.append(observer)
    }
    
    func announce() {
        for observer in observers {
            observer.upload()
        }
    }
}

// 선수들은 오픈와드가 나올때 마다 구독 가능
struct Athlete : Observer {
    var crossfitGames: CrossfitGames
    var _name : String
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }

    func upload() {
        print("\(crossfitGames.workouts)이 공개되었어요 🏋🏻‍♀️\(name)님 화이팅!!")
    }
}

var crossfitGames : CrossfitGames = CrossfitGames(observers: [], _workouts: "22.1 WORKOUT 🏋🏻‍♀️")

let athlete1 : Athlete = Athlete(crossfitGames: crossfitGames, _name: "Athlete1")

// athlete1 은 구독 가능
crossfitGames.subscribe(observer: athlete1)
// 크로스핏 게임즈가 이벤트를 announce
crossfitGames.announce()
// output : 22.1 WORKOUT 🏋🏻‍♀️이 공개되었어요 🏋🏻‍♀️Athlete1님 화이팅!!

// 새로운 이벤트 발생
crossfitGames.workouts = "22.2 WORKOUT 🤸‍♀️"
// output : 22.2 WORKOUT 🤸‍♀️이 공개되었어요 🏋🏻‍♀️Athlete1님 화이팅!!

// athlete2 추가
let athlete2 : Athlete = Athlete(crossfitGames: crossfitGames, _name: "Athlete2")
crossfitGames.subscribe(observer: athlete2)

// 새로운 이벤트 발생
crossfitGames.workouts = "22.3 WORKOUT 📦🏃‍♀️"

/*
 output :
 22.3 WORKOUT 📦🏃‍♀️이 공개되었어요 🏋🏻‍♀️Athlete1님 화이팅!!
 22.3 WORKOUT 📦🏃‍♀️이 공개되었어요 🏋🏻‍♀️Athlete2님 화이팅!!
 */
