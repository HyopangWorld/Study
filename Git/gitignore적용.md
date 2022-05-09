.gitignore 파일은 그냥 push 해서 적용하면 되지만, </br>
기존에 있던 레포에 .gitignore를 추가할 경우 반영이 안될 때가 있다. </br>
cache를 날리는 명령어 뒤 .gitignore를 추가해주면 됨  </br>

```
git rm -r --cached {특정 디렉터리 경로 지정 가능}
git add .
git commit -m "add .gitignore"
git push
```
