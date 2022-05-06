Xcode 업데이트 이후 갑자기 팀 Identify가 맞지 않는다며 오류가 났다. </br>

```swift
Showing All Messages
No account for team "{Team Identify}". Add a new account in the Accounts preference pane or verify that your accounts have valid credentials.

No profiles for '{Profiles Name}' were found: Xcode couldn't find any iOS App Development provisioning profiles matching '{Profiles Name}'.
```
</br>
이럴때는 당황하지 않고 project.pbxproj에서 DevelopmentTeam 값이 제대로 되어있는지 확인해주면 된다. </br>
나는 어디서 꼬였는지는 모르겠지만, 특정 스키마만 다른 Identify로 바뀌어 있어서 오류가 났었다. 어떤 팀계정의 Identify인지,,, 모르겠다,,</br> </br>

[결론] </br>
yeogoo.xcodeproj 패키지 안에서 project.pbxroj의 DevelopmentTeam 값을 </br>
해당 프로젝트를 소유하고 있는 팀 계정의 Identify로 입력해주면 된다!

</br></br>
[참고] </br>
https://devshin93.tistory.com/123
