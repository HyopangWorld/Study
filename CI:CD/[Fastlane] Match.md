Certification 과 Provisioing 파일을 통합하고 관리하기 위해 클라우드로 내쫓기로 한다.

처음엔 서버팀에서 사용하는 AWS s3를 사용하려고 buket 생성 후 연결까지는 했으나, 

`initialize': No such file or directory @ rb_sysopen

이런 오류가 난다,, 대충 fastlane ruby - aws 모듈에 명령어를 찾을 수 없다는 에러였는데,

전부 지웠다가 재설치해도 계속해서 같은 오류가 발생했다.


탈모오기 직전이라 회사 토이프로젝트 시 사용하는 github로 이전,
> 지금 match로 사용할 수 있는 저장소는 google cloud, s3, github 3가지 이다.

너무 잘되서 눈물이 날지경이었다. 암튼 해결 완료 후

1. match nuke 를 통해 기존 certification과 provisiong을 제거해 준다.
2. match 를 통해 사용할 타입의 provisiong을 생성해 준다. 편의를 위해 force_new_device 옵션 추가
3. match 동기화와 재생성 편의를 위한 lane도 생성해준다.
4. 동료들에게 배포해주자.
5. 꺄르륵


Debug 배포 시 : signing -> build -> upload to app distribution -> send message to slack
+------+--------------------------------------------+-------------+
|                        fastlane summary                         |
+------+--------------------------------------------+-------------+
| Step | Action                                     | Time (in s) |
+------+--------------------------------------------+-------------+
| 1    | default_platform                           | 0           |
| 2    | sync_code_signing                          | 1           |
| 3    | Switch to ios common_build lane            | 0           |
| 4    | clear_derived_data                         | 0           |
| 5    | update_code_signing_settings               | 0           |
| 6    | build_app                                  | 368         |
| 7    | Switch to ios upload_app_distribution lane | 0           |
| 8    | firebase_app_distribution                  | 20          |
| 9    | clean_build_artifacts                      | 0           |
| 10   | Switch to ios send_slack lane              | 0           |
| 11   | get_version_number                         | 0           |
| 12   | get_build_number                           | 0           |
| 13   | slack                                      | 0           |
+------+--------------------------------------------+-------------+
