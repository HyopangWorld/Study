## Async/Await

callback 대신 사용할 수 있는 async/await (swift 5.5) 
<br/>

순차적으로 해야하는 작업이 있을때, 기존에 중첩 콜백을 사용했다.

<br/>

```swift
func fetchImage(completion: @escaping ((_ url: URL) -> Data)) {
  let url = URL(String: urlStr)!
  let data = try! Data(contentsOf: url)
  completion(data)
}

func decodeImage(completion: @escaping ((_ data: Data) -> UIImage)) {
  let uiImage = try! UIImage(data: data)
  completion(uiImage)
}

// using data (순차적으로 실행)
fetchImage(urlStr: "/files/dogs.jpeg") { data in
   decodeImage(data) { image in
     // set profile image
   }
}
```
<br/>

async/await을 쓴다면 아래처럼 중첩을 없앨 수 있다.

<br/>

```swift
func fetchImage(urlStr: String) async throws -> Data {
  let url = URL(String: urlStr)!
  return try! Data(contentsOf: url)
}

func decodeImage(data: Data) async throws -> UIImage {
  return try! UIImage(data: data)
}

func setImage() async throws -> UIImage {
  let dataResource = try await fetchImage(urlStr: "/files/dogs.jpeg")
  let imageResource = try await decodeImage(data: dataResource)
  return imageResource
}

// using data (순차적으로 실행)
let dataResource = try await fetchImage(urlStr: "/files/dogs.jpeg")
let imageResource = try await decodeImage(data: dataResource)
```

<br/>
<br/>

## 동시성을 활용하려면?
아래처럼 사용할 경우, 순차적으로 실행된다.

<br/>

```swift
func loadFeedEntries() async throws -> Feed.Entries {
    let feed = try await loadFeed()
    let banners = try await loadBanner()
    let articles = try await loadArticles()
    let status = try await loadRegularPayment()
    let watching = try await loadWantedPlusWatching()

    return Feed.Entries(
        ...
        banners: banners,
        articles: articles,
        status: status,
        watching: watching,
        ...
    )
}
```
<br/>

동시성을 활용하려면 아래와 같이 사용한다. 
<br/>
***await을 결합 부분에만 호출하는 것.***

<br/>

```swift
func loadFeedEntries() async throws -> Feed.Entries {
    async let feed = loadFeed()
    async let banners = loadBanner()
    async let articles = loadArticles()
    async let status = loadRegularPayment()
    async let watching = loadWantedPlusWatching()

    return try await Feed.Entries(
        ...
        banners: banners,
        articles: articles,
        status: status,
        watching: watching,
        ...
    )
}
```


[참고] <br/>
https://ios-development.tistory.com/589 <br/>
https://zeddios.tistory.com/1230 <br/>
https://github.com/apple/swift-evolution/blob/main/proposals/0296-async-await.md#suspension-points <br/>
