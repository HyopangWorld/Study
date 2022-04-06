## Fastlane 버전 정보 가져오기

1. .xcodeproj 설정 파일의 version, build 코드 가져오기
```
// Marketing version
version = get_version_number(xcodeproj: "{Project}.xcodeproj")

// build number
build = get_build_number(xcodeproj: "{Project}.xcodeproj")
```

2. Testflight에 올라온 최종 버전 코드 가져오기
```
latest_testflight_build_number
```

[참고] <br/>
https://docs.fastlane.tools/actions/get_version_number/ <br/>
https://docs.fastlane.tools/actions/get_build_number/ <br/>
