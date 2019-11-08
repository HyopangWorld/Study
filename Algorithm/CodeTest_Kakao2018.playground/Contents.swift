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
//
//
//struct PageInfo {
//    var myLink: String?
//    var basicScore: Int = 0
//    var otherLink = [String]()
//    var linkScore: Int {
//        get {
//            return self.otherLink.count
//        }
//    }
//}
//
//func solution4(_ word:String, _ pages:[String]) -> Int {
//    var pageInfos = [PageInfo]()
//
//    let url = #"(https://(\w*:\w*@)?[-\w.]+(:\d+)?(/([\w/_.]*(\?\S+)?)?)?)"#
//    let myLinkEx = #"<meta property="og:url" content="\b"#+url+#"\b[^>]*>(.*?)"#
//    let pattern = #"([^{A-Za-z}]|^)"#
//    let aTag = #"<a href=\"\b"#+url+#"\b[^>]*>(.*?)</a>"#
//
//    func splitTag(_ pageWord: [String.SubSequence], _ startExpress: String, _ endExpress: String) -> Array<String.SubSequence> {
//        let start = pageWord.filter { String($0).matchingExpression(startExpress) }.map{"\($0)"}.reduce(""){$0+$1}
//        let end = pageWord.filter { String($0).matchingExpression(endExpress) }.map{"\($0)"}.reduce(""){$0+$1}
//        let startIndex = (pageWord.firstIndex(of: Substring(start)) ?? 0) + 1
//        let endIndex = (pageWord.lastIndex(of: Substring(end)) ?? 0)
//        return Array(pageWord[startIndex ..< endIndex])
//    }
//
//    func getMatchScore() -> [Double] {
//        var score = [Double]()
//
//        for i in 0 ..< pageInfos.count {
//            var matchScore = 0.0
//
//            for j in 0 ..< pageInfos.count {
//                for link in pageInfos[j].otherLink {
//                    if pageInfos[i].myLink == link {
//                         matchScore += Double(pageInfos[j].basicScore) / Double(pageInfos[j].linkScore)
//                    }
//                }
//            }
//            matchScore += Double(pageInfos[i].basicScore)
//            score.append(matchScore)
//        }
//
//        return score
//    }
//
//    for page in pages {
//        let pageWord = page.split(separator: "\n")
//
//        let head = splitTag(pageWord, #"<head>"#, #"</head>"#)
//        let myLink = head.filter { String($0).matchingExpression(myLinkEx) }
//            .map { String($0).split(separator: "\"")
//            .filter { String($0).matchingExpression(url) }.reduce(""){$0+$1} }
//            .reduce(""){$0+$1}
//
//        let body = splitTag(pageWord, #"<body>"#, #"</body>"#)
//
//        let basicScore = body.map{ String($0) }.reduce(""){$0+$1}.matchingReplace(pattern).split(separator: " ")
//            .map { String($0).matchingExpressionNumbers(#"\b"#+word.uppercased()+#"\b"#)}.reduce(0){$0+$1}
//
//        let link = body.filter { String($0).matchingExpression(aTag) }
//            .map { String($0).split(separator: "\"")
//            .filter { String($0).matchingExpression(url) }.reduce(""){$0+$1} }
//
//        pageInfos.append(PageInfo(myLink: myLink, basicScore: basicScore, otherLink: link))
//
//        print("\(word)\n\(body)\n => myLink: \(myLink) basicScore : \(basicScore)  link : \(link)\n")
//    }
//
//    let matchScore = getMatchScore()
//
//    print("=> matchScore : \(matchScore) = index : \(matchScore.firstIndex(of: matchScore.max() ?? matchScore[0]) ?? -1) \n")
//
//
//
//    return matchScore.firstIndex(of: matchScore.max() ?? matchScore[0]) ?? 0
//}
//
//extension String {
//    func matchingExpression(_ regularExpression: String) -> Bool {
//        do {
//            let regex = try NSRegularExpression(pattern: regularExpression , options: .caseInsensitive)
//            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
//                return true
//            }
//        }catch{
//            print(error.localizedDescription)
//            return false
//        }
//        return false
//    }
//
//    func matchingReplace(_ regularExpression: String) -> String {
//        do {
//            let regex = try NSRegularExpression(pattern: regularExpression , options: .caseInsensitive)
//            return regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count), withTemplate: " ")
//        }catch{
//            print(error.localizedDescription)
//            return self
//        }
//    }
//
//    func matchingExpressionNumbers(_ regularExpression: String) -> Int {
//        do {
//            let regex = try NSRegularExpression(pattern: regularExpression , options: .caseInsensitive)
//            return regex.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count))
//        }catch{
//            print(error.localizedDescription)
//            return 0
//        }
//    }
//}
//
//print("\(solution4("Muzi", ["<html lang=\"ko\" xml:lang=\"ko\" xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <meta charset=\"utf-8\">\n  <meta property=\"og:url\" content=\"https://careers.kakao.com/interview/list\"/>\n</head>  \n<body>\n<a href=\"https://programmers.co.kr/learn/courses/4673\"></a>#!MuziMuzi!)jayg07con&&\n\n</body>\n</html>", "<html lang=\"ko\" xml:lang=\"ko\" xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <meta charset=\"utf-8\">\n  <meta property=\"og:url\" content=\"https://www.kakaocorp.com\"/>\n</head>  \n<body>\ncon%\tmuzI92apeach&2<a href=\"https://hashcode.co.kr/tos\"></a>\n\n\t^\n</body>\n</html>"]))")

func solution5(_ record:[String]) -> [String] {
    var nameList = [String:String]()
    var history = [String]()
    
    for item in record {
        let array = item.split(separator: " ")
        let (action, id) = ("\(array[0])", "\(array[1])")
        
        if action == "Enter" || action == "Change" {
            nameList.updateValue("\(array[2])", forKey: id)
        }
    }
    
    for item in record {
        let array = item.split(separator: " ")
        let (action, id) = ("\(array[0])", "\(array[1])")
        
        switch action {
        case "Enter" :
            history.append("\(nameList[id] ?? "\(array[2])")님이 들어왔습니다.")
        case "Leave" :
            history.append("\(nameList[id] ?? "\(array[2])")님이 나갔습니다.")
        default : continue
        }
    }
    
    return history
}

print("\(solution5(["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"]))")


