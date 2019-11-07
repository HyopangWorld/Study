import Foundation
//
///*비밀지도*/
//
//func solution(_ n: Int, _ arr1: [Int], _ arr2: [Int]) -> [String] {
//    var answer: [String] = []
//
//    for i in 0 ..< n {
//        var val = String((arr1[i] | arr2[i]), radix: 2)
//
//        val = val.replacingOccurrences(of: "0", with: " ", options: .literal, range: nil)
//        val = val.replacingOccurrences(of: "1", with: "#", options: .literal, range: nil)
//
//        for _ in 0 ..< (n - val.count) {
//            val = " " + val
//        }
//
//        answer.append(val)
//    }
//
//    return answer
//}
//
//print("\(solution(5, [9, 20, 28, 18, 11], [30, 1, 21, 17, 28]))")
//
//
///*다트 게임*/
//
//func solution2(_ dartResult:String) -> Int {
//    let dart = Array(dartResult)
//    var temp = [Int]()
//
//    for i in 0 ..< dart.count {
//        var str = ""
//        if i-1 >= 0 { str = String(dart[i-1]) }
//
//        if i-2 >= 0
//        && String(dart[i-1]).rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
//        && String(dart[i-2]).rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
//            str = String(dart[i-2]) + String(dart[i-1])
//        }
//
//        switch dart[i] {
//        case "S":
//            temp.append((str as NSString).integerValue)
//        case "D":
//            temp.append(Int(pow((str as NSString).doubleValue, 2.0)))
//        case "T":
//            temp.append(Int(pow((str as NSString).doubleValue, 3.0)))
//        case "*":
//            if temp.endIndex - 2 >= 0 { temp[temp.endIndex - 2] = temp[temp.endIndex - 2] * 2 }
//            if temp.endIndex - 1 >= 0 { temp[temp.endIndex - 1] = temp[temp.endIndex - 1] * 2 }
//        case "#":
//            if temp.endIndex - 1 >= 0 { temp[temp.endIndex - 1] = -1 * temp[temp.endIndex - 1] }
//
//        default: break
//        }
//    }
//
//    return temp.reduce(0){$0 + $1}
//}
//
//print("\(solution2("1D2S#10S"))")
//
//
//func solution3(_ cacheSize:Int, _ cities:[String]) -> Int {
//    if 30 < cacheSize && cacheSize < 0 { return -1 }
//
//    var timer = 0
//    var stack = [String]()
//
//    func appendStack(_ city: String){
//        stack.append(city)
//        if stack.count > cacheSize { stack.remove(at: 0) }
//    }
//
//    func getStack(_ city: String){
//        guard let index = stack.firstIndex(of: city) else { return }
//        stack.remove(at: index)
//        appendStack(city)
//    }
//
//    for city in cities.map({ $0.uppercased() }) {
//        if stack.contains(city) {
//            getStack(city)
//            timer += 1
//        }
//        else {
//            appendStack(city)
//            timer += 5
//        }
//    }
//
//    return timer
//}
//
//print("\(solution3(0, ["Jeju", "Pangyo", "Seoul", "NewYork", "LA"]))")

// 기본점수 - 해당 웹페이지의 텍스트 중, 검색어가 등장하는 횟수이다. (대소문자 무시)
// 외부 링크 수 - 해당 웹페이지에서 다른 외부 페이지로 연결된 링크의 개수이다.
// 매칭점수 -  해당 웹페이지로 링크가 걸린 다른 웹페이지의 기본점수 ÷ 외부 링크 수의 총합이다. 한 웹페이지의 매칭점수는 기본점수와 링크점수의 합으로 계산한다.
// => 매칭점수가 가장 높은 웹페이지의 index를 구하라. 만약 그런 웹페이지가 여러 개라면 그중 번호가 가장 작은 것을 구하라.

// pages는 HTML 형식의 웹페이지가 문자열 형태로 들어있는 배열이고, 길이는 1 이상 20 이하이다.
// 한 웹페이지 문자열의 길이는 1 이상 1,500 이하이다.
// 웹페이지의 index는 pages 배열의 index와 같으며 0부터 시작한다.
// 한 웹페이지의 url은 HTML의 <head> 태그 내에 <meta> 태그의 값으로 주어진다. 예를들어, 아래와 같은 meta tag가 있으면 이 웹페이지의 url은 https://careers.kakao.com/index 이다. <meta property=og:url content=https://careers.kakao.com/index />
// 한 웹페이지에서 모든 외부 링크는 <a href=https://careers.kakao.com/index>의 형태를 가진다. <a> 내에 다른 attribute가 주어지는 경우는 없으며 항상 href로 연결할 사이트의 url만 포함된다. 위의 경우에서 해당 웹페이지는 https://careers.kakao.com/index 로 외부링크를 가지고 있다고 볼 수 있다.
// 모든 url은 https:// 로만 시작한다.
// 검색어 word는 하나의 영어 단어로만 주어지며 알파벳 소문자와 대문자로만 이루어져 있다.
// word의 길이는 1 이상 12 이하이다.
// 검색어를 찾을 때, 대소문자 구분은 무시하고 찾는다.
// 검색어는 단어 단위로 비교하며, 단어와 완전히 일치하는 경우에만 기본 점수에 반영한다.
// 단어는 알파벳을 제외한 다른 모든 문자로 구분한다.
// 예를들어 검색어가 aba 일 때, abab abababa는 단어 단위로 일치하는게 없으니, 기본 점수는 0점이 된다.
// 만약 검색어가 aba 라면, aba@aba aba는 단어 단위로 세개가 일치하므로, 기본 점수는 3점이다.
// 결과를 돌려줄때, 동일한 매칭점수를 가진 웹페이지가 여러 개라면 그중 index 번호가 가장 작은 것를 리턴한다
// 즉, 웹페이지가 세개이고, 각각 매칭점수가 3,1,3 이라면 제일 적은 index 번호인 0을 리턴하면 된다.

struct PageInfo {
    var myLink: String?
    var basicScore: Int = 0
    var otherLink: [String]?
    var linkScore: Int = 0 {
        get {
            return self.otherLink?.count
        }
    }
}

func solution4(_ word:String, _ pages:[String]) -> Int {
    var pageInfos = [PageInfo]()
    
    let url = #"(https://(\w*:\w*@)?[-\w.]+(:\d+)?(/([\w/_.]*(\?\S+)?)?)?)"#
    let myLinkEx = #"<meta property="og:url" content="\b"#+url+#"\b[^>]*>(.*?)"#
    let pattern = #"([^{A-Za-z\xAA\xB5\xBA\xC0-\xD6\xD8-\xF6\xF8-\xFF}]|^)"#+word+#"([^{A-Za-z\xAA\xB5\xBA\xC0-\xD6\xD8-\xF6\xF8-\xFF}]|$)"#
    let aTag = #"<a href=\"\b"#+url+#"\b[^>]*>(.*?)</a>"#
    
    func splitTag(_ pageWord: [String.SubSequence], _ startExpress: String, _ endExpress: String) -> Array<String.SubSequence> {
        let start = pageWord.filter { String($0).matchingExpression(startExpress) }.map{"\($0)"}.reduce(""){$0+$1}
        let end = pageWord.filter { String($0).matchingExpression(endExpress) }.map{"\($0)"}.reduce(""){$0+$1}
        let startIndex = (pageWord.firstIndex(of: Substring(start)) ?? 0) + 1
        let endIndex = (pageWord.lastIndex(of: Substring(end)) ?? 0)
        return Array(pageWord[startIndex ..< endIndex])
    }
    
    func getMatchScore() -> [Int] {
        var score = [Int]()
        
        for i in 0 ..< pageInfos.count {
            if pageInfos[i].linkScore <= 0 {
                score.append(0)
            }
            pageInfos[i].otherLink.map{  }
        }
        
        return score
    }
    
    for page in pages {
        let pageWord = page.split(separator: "\n")
        
        let head = splitTag(pageWord, #"<head>"#, #"</head>"#)
        let myLink = head.filter { String($0).matchingExpression(myLinkEx) }
            .map { String($0).split(separator: "\"")
            .filter { String($0).matchingExpression(url) }.reduce(""){$0+$1} }
            .reduce(""){$0+$1}
        
        let body = splitTag(pageWord, #"<body>"#, #"</body>"#)
        let basicScore = body.map { String($0).split(separator: " ").filter { String($0).matchingExpression(pattern)}.count }.reduce(0){ $0 + $1 }
        let link = body.filter { String($0).matchingExpression(aTag) }
            .map { String($0).split(separator: "\"")
            .filter { String($0).matchingExpression(url) }.reduce(""){$0+$1} }
        
        pageInfos.append(PageInfo(myLink: myLink, basicScore: basicScore, otherLink: link))
        
        print("\(word)\n\(body)\n => basicScore : \(basicScore)  linkNum : \(link.count)\n")
    }
    
    let matchScore = getMatchScore()
    
    print("=> matchScore : \(matchScore)) = index : \(matchScore.firstIndex(of: matchScore.max() ?? matchScore[0]) ?? -1) \n")
    
    return matchScore.firstIndex(of: matchScore.max() ?? matchScore[0]) ?? -1
}

extension String {
    func matchingExpression(_ regularExpression: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regularExpression , options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        }catch{
            print(error.localizedDescription)
            return false
        }
        return false
    }
}

print("\(solution4("Muzi", ["<html lang=\"ko\" xml:lang=\"ko\" xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <meta charset=\"utf-8\">\n  <meta property=\"og:url\" content=\"https://careers.kakao.com/interview/list\"/>\n</head>  \n<body>\n<a href=\"https://programmers.co.kr/learn/courses/4673\"></a>#!MuziMuzi!)jayg07con&&\n\n</body>\n</html>", "<html lang=\"ko\" xml:lang=\"ko\" xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <meta charset=\"utf-8\">\n  <meta property=\"og:url\" content=\"https://www.kakaocorp.com\"/>\n</head>  \n<body>\ncon%\tmuzI92apeach&2<a href=\"https://hashcode.co.kr/tos\"></a>\n\n\t^\n</body>\n</html>"]))")
