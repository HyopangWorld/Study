
## NSPredicate로 쿼리 데이터 중복제거해서 가져오기

propertiesToGroupBy 를 사용해서 중복제거를 한다. <br/>
이때 그룹바이 사용시 resultType은 꼭 NSDictionaryResultType으로 설정해주어야한다.<br/>
그리고 rdb에서 사용하듯이 쿼리문에 groupby를 사용 시 그룹을 지을 칼럼과 그 칼럼을 세어 줄 NSExpressionDescription을 넣어주어야한다. <br/>

```swift
let keypathExp = NSExpression(forKeyPath: "mainCategory")
let expression = NSExpression(forFunction: "count:", arguments: [keypathExp])

let countDesc = NSExpressionDescription()
countDesc.expression = expression
countDesc.name = "count"
countDesc.expressionResultType = .integer64AttributeType
        
let request: NSFetchRequest<Category> = Category.fetchRequest()
request.propertiesToGroupBy = [ "mainCategory" ]
request.propertiesToFetch = [ countDesc, "mainCategory"]
request.resultType = .dictionaryResultType

do {
  let data = try self.context.fetch(request)
} catch {
  print(error.localizedDescription)
}
```
