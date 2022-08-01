[Error] Library not loaded: @rpath/XCTest.framework/XCTest </br>

quick이랑 nimble을 app target에 잘못 넣어서 발생하는 에러다. </br>
test framework는 test target에만 넣어야한다. </br>

https://rhammer.tistory.com/345
