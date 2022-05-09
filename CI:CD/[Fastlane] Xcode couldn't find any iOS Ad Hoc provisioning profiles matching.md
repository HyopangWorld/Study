iOS 15 버전 반영 및 OS 업뎃을 위해 XCode 13.1 -> 13.3 업데이트 이후 </br>
Xcode couldn't find any iOS Ad Hoc provisioning profiles matching 이라는 오류 발생 하였다. </br>

provisioning 파일 삭제도 후 재생성도 해보고, 수동으로도 넣어보고 했지만 전부 소용이 없었다,,, </br>

1. 첫번째 방법 sigh 명령어
fastlane에 signing을 해서 provisioning을 직접 생성 해주는 명령어 sigh을 하는 방법. </br>
https://docs.fastlane.tools/actions/get_provisioning_profile/

</br>
원하는 siging 타입을 골라서 명령어를 때려주면 된다. 


</br>

```
fastlane sigh --adhoc

fastlane sigh --development

fastlane sigh download_all
```

</br>

fastlane sigh download_all 이 명령어를 실행시키니 아래와 같은 오류가 발생했고, adhoc에 문제가 있다는 것을 알게되었다.

```
Failure to decode ./AdHoc_.mobileprovision. Exit: 1: security: unable to open "./AdHoc_.mobileprovision" for reading: No such file or directory


Looking for related GitHub issues on fastlane/fastlane...

Found no similar issues. To create a new issue, please visit:
https://github.com/fastlane/fastlane/issues/new
Run `fastlane env` to append the fastlane environment to your issue
```

fastlane env 명령어 실행 후 fastlane sigh download_all 실행은 안됨
</br>

2. Xcode로 Achive 한거 Ad-hoc으로 말아서 ipa export 한번 해보기 </br>
이건 문제 없이 잘되는데,,, 혹시나 해서 xcode로 해본 뒤 fastlane으로 시도 </br>

.... 성공..... 다음엔 auto로 ad-hoc 한번 말아주고 fastlane 실행하기,,,
