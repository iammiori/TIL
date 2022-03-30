# TIL

## RxSwift
|주제|코드|정리|
|:---:|:---:|:---:|
|**Observable**|[Observable.swift](RxSwift/RxSwiftTIL/0_CreateObservable.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-1a)|
|**Disposables**|[Disposables.swift](RxSwift/RxSwiftTIL/0_CreateObservable.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-2.-Disposables)|
|**Subject 언제쓸까 고민 1**|[WhySubject.swift](RxSwift/RxSwiftTIL/3_WhySubject.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-4.-Subject)|
|**PublishSubject**|[PublishSubject.swift](RxSwift/RxSwiftTIL/1_PublishSubject.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-4-1.-PublishSubject)|
|**BehaviorSubject**|[BehaviorSubject.swift](RxSwift/RxSwiftTIL/2_BehaviorSubject.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-4-2.-BehaviorSubject)|
|**ReplaySubject**|[ReplaySubject.swift](RxSwift/RxSwiftTIL/4_ReplaySubject.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-4-3.-ReplaySubject)|
|**AsyncSubject**|[AsyncSubject.swift](RxSwift/RxSwiftTIL/5_AsyncSubject.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-4-4.-AsyncSubject)|
|**Relay 언제쓸까**||[✏️블로그정리](https://velog.io/@iammiori/RxSwift-5.-Relay)|
|**종류별 Relay**|[Relay.swift](RxSwift/RxSwiftTIL/6_Relay.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-5-1.-Relay-종류)|
|**Operator-Create**|[CreateOperator.swift](RxSwift/RxSwiftTIL/7_Operator_Create.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-6-1.-Operators-Create)|
|**Operator-Filter**|[FilterOperator.swift](RxSwift/RxSwiftTIL/8_Operator_Filter.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-6-1.-Operators-Filter)|
|**Operator-Transforming**|[TransformingOperator.swift](RxSwift/RxSwiftTIL/9_Operator_Transforming.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-6-3.-Operators-Transforming)|
|**Operator-Combine**|[CombineOperator.swift](RxSwift/RxSwiftTIL/10_Operator_Combine.playground/Contents.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-6-4.-Operators-Combine)|
|**Driver;리소스낭비예방**|[Driver.swift](RxSwift/RxSwiftTIL/RxSwiftTIL/DriverVC.swift)|[✏️블로그정리](https://velog.io/@iammiori/RxSwift-9-1.-RxCocoa-Traits-Driver-리소스-낭비-예방)|
|**Rx + URLSession + MVVM**|[Model - 기능](RxSwift/RxSwiftTIL/RxSwiftTIL/Model/BoxOfficeModel.swift)<br>[Model - APIResponseModel](RxSwift/RxSwiftTIL/RxSwiftTIL/Model/BoxOfficeResponse.swift)<br>[Model - Network](RxSwift/RxSwiftTIL/RxSwiftTIL/Network/BoxOfficeNetwork.swift)<br>[ViewModel](RxSwift/RxSwiftTIL/RxSwiftTIL/ViewModel/BoxOfficeViewModel.swift)<br>[View](RxSwift/RxSwiftTIL/RxSwiftTIL/BoxOfficeVC.swift)|[✏️블로그정리-1](https://velog.io/@iammiori/RxSwift-14.-RxSwift-URLSession2-MVVM-리팩토링)<br>[✏️블로그정리-2](https://velog.io/@iammiori/RxSwift-15.-RxSwift-URLSession-MVVM-리팩토링-2)<br>[✏️블로그정리-3](https://velog.io/@iammiori/RxSwift-16.-RxSwift-URLSession-MVVM-리팩토링-3)|

### 그래서 왜 굳이 Rx를 써야할까에 대한 고민의 흔적 🐾🐾🐾🐾
- (220209) [옵저버패턴 코드](RxSwift/RxSwiftTIL/a_ObserverPattern.playground/Contents.swift) vs  [Rx-PublishSubject 코드](RxSwift/RxSwiftTIL/a_WhyRx0.playground/Contents.swift) 
  - **그래서 왜 Rx?**   [✏️블로그정리](https://velog.io/@iammiori/Rxswift-3.-그래서-왜-굳이-Rx-첫번째-이야기)
    - 1. 코드가 짧아졌다.
    - 2. onCompleted, onError 등 종료 이벤트 처리가 쉽게 가능하다.

- (220221) [textfield를 입력한 값 valid 검사후 label에 결과 표시하기 코드 (delegate vs. rx)](RxSwift/RxSwiftTIL/RxSwiftTIL/BindingVC.swift)
  - **그래서 왜 Rx?**   [✏️블로그정리](https://velog.io/@iammiori/RxSwift-8-2.-RxCocoa-Binding)
    - 1. 코드가 단순해졌다.
    - 2. delegate를 사용하지 않아도 된다.
    - 3. 데이터 흐름과 변화가 직관적으로 보인다.

## SwiftUI
- swiftUI 요소 사용해보기
   - stack
   - scroll
   - form
