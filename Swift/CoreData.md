## CoreData

디바이스에 영구적으로 데이터를 저장할때, 사용하는 framework.
coredata는 앱 모델의 계층이다.
<br/>

<br/>

## Entity의 구성
하나 이상의 속성으로 정의되는 어떤 것 (Things)
- Abstrct Entity: 인스턴스화 되지 않는 상위 개념으로만 사용되는 Entity일 경우 체크
- Parent Entity: 다른 Entity를 지정해서 상속받을 수 있음
- Class : 이 Entity의 인스턴스를 생성할 클래스
  - name: 클래스명
  - Module: 이 엔터티의 클래스가 속한 프로젝트 위치
  - Codegen: 



## Relationships
엔터티가 관련되는 방식과 변경 사항이 엔터티 간에 전파되는 방식을 지정합니다.
- 관계형 RDB 처럼 관계형성이 가능함.
- 관계는 이름, 대상 엔터티, 삭제 규칙, 카디널리티 유형(하나 또는 여러 개), 관계를 저장소에 저장해야 하는지 여부에 대한 설정(일시적인지?), 저장 시 값(선택 사항인지?).
- 모든 관계를 역 관계로 구성해야 합니다.

```swift
{}
```
<br/>

![스크린샷 2022-04-12 오전 11 42 32](https://user-images.githubusercontent.com/18113297/162868751-4b8daf37-facb-42d8-8dca-624062f54165.png)

[참고] <br/>
https://developer.apple.com/documentation/coredata <br/>
