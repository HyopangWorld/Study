import Foundation

/*비밀지도*/

func solution(_ n: Int, _ arr1: [Int], _ arr2: [Int]) -> [String] {
    var answer: [String] = []

    for i in 0 ..< n {
        var val = String((arr1[i] | arr2[i]), radix: 2)

        val = val.replacingOccurrences(of: "0", with: " ", options: .literal, range: nil)
        val = val.replacingOccurrences(of: "1", with: "#", options: .literal, range: nil)

        for _ in 0 ..< (n - val.count) {
            val = " " + val
        }

        answer.append(val)
    }

    return answer
}

print("\(solution(5, [9, 20, 28, 18, 11], [30, 1, 21, 17, 28]))")


/*다트 게임*/

func solution2(_ dartResult:String) -> Int {
    let dart = Array(dartResult)
    var temp = [Int]()

    for i in 0 ..< dart.count {
        var str = ""
        if i-1 >= 0 { str = String(dart[i-1]) }

        if i-2 >= 0
        && String(dart[i-1]).rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        && String(dart[i-2]).rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            str = String(dart[i-2]) + String(dart[i-1])
        }

        switch dart[i] {
        case "S":
            temp.append((str as NSString).integerValue)
        case "D":
            temp.append(Int(pow((str as NSString).doubleValue, 2.0)))
        case "T":
            temp.append(Int(pow((str as NSString).doubleValue, 3.0)))
        case "*":
            if temp.endIndex - 2 >= 0 { temp[temp.endIndex - 2] = temp[temp.endIndex - 2] * 2 }
            if temp.endIndex - 1 >= 0 { temp[temp.endIndex - 1] = temp[temp.endIndex - 1] * 2 }
        case "#":
            if temp.endIndex - 1 >= 0 { temp[temp.endIndex - 1] = -1 * temp[temp.endIndex - 1] }

        default: break
        }
    }

    return temp.reduce(0){$0 + $1}
}

print("\(solution2("1D2S#10S"))")


func solution3(_ cacheSize:Int, _ cities:[String]) -> Int {
    if 30 < cacheSize && cacheSize < 0 { return -1 }

    var timer = 0
    var stack = [String]()

    func appendStack(_ city: String){
        stack.append(city)
        if stack.count > cacheSize { stack.remove(at: 0) }
    }

    func getStack(_ city: String){
        guard let index = stack.firstIndex(of: city) else { return }
        stack.remove(at: index)
        appendStack(city)
    }

    for city in cities.map({ $0.uppercased() }) {
        if stack.contains(city) {
            getStack(city)
            timer += 1
        }
        else {
            appendStack(city)
            timer += 5
        }
    }

    return timer
}

print("\(solution3(0, ["Jeju", "Pangyo", "Seoul", "NewYork", "LA"]))")


struct PageInfo {
    var myLink: String?
    var basicScore: Int = 0
    var otherLink = [String]()
    var linkScore: Int {
        get {
            return self.otherLink.count
        }
    }
}

func solution4(_ word:String, _ pages:[String]) -> Int {
    var pageInfos = [PageInfo]()

    let url = #"(https://(\w*:\w*@)?[-\w.]+(:\d+)?(/([\w/_.]*(\?\S+)?)?)?)"#
    let myLinkEx = #"<meta property="og:url" content="\b"#+url+#"\b[^>]*>(.*?)"#
    let pattern = #"([^{A-Za-z}]|^)"#
    let aTag = #"<a href=\"\b"#+url+#"\b[^>]*>(.*?)</a>"#

    func splitTag(_ pageWord: [String.SubSequence], _ startExpress: String, _ endExpress: String) -> Array<String.SubSequence> {
        let start = pageWord.filter { String($0).matchingExpression(startExpress) }.map{"\($0)"}.reduce(""){$0+$1}
        let end = pageWord.filter { String($0).matchingExpression(endExpress) }.map{"\($0)"}.reduce(""){$0+$1}
        let startIndex = (pageWord.firstIndex(of: Substring(start)) ?? 0) + 1
        let endIndex = (pageWord.lastIndex(of: Substring(end)) ?? 0)
        return Array(pageWord[startIndex ..< endIndex])
    }

    func getMatchScore() -> [Double] {
        var score = [Double]()

        for i in 0 ..< pageInfos.count {
            var matchScore = 0.0

            for j in 0 ..< pageInfos.count {
                for link in pageInfos[j].otherLink {
                    if pageInfos[i].myLink == link {
                         matchScore += Double(pageInfos[j].basicScore) / Double(pageInfos[j].linkScore)
                    }
                }
            }
            matchScore += Double(pageInfos[i].basicScore)
            score.append(matchScore)
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

        let basicScore = body.map{ String($0) }.reduce(""){$0+$1}.matchingReplace(pattern).split(separator: " ")
            .map { String($0).matchingExpressionNumbers(#"\b"#+word.uppercased()+#"\b"#)}.reduce(0){$0+$1}

        let link = body.filter { String($0).matchingExpression(aTag) }
            .map { String($0).split(separator: "\"")
            .filter { String($0).matchingExpression(url) }.reduce(""){$0+$1} }

        pageInfos.append(PageInfo(myLink: myLink, basicScore: basicScore, otherLink: link))

        print("\(word)\n\(body)\n => myLink: \(myLink) basicScore : \(basicScore)  link : \(link)\n")
    }

    let matchScore = getMatchScore()

    print("=> matchScore : \(matchScore) = index : \(matchScore.firstIndex(of: matchScore.max() ?? matchScore[0]) ?? -1) \n")



    return matchScore.firstIndex(of: matchScore.max() ?? matchScore[0]) ?? 0
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

    func matchingReplace(_ regularExpression: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: regularExpression , options: .caseInsensitive)
            return regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count), withTemplate: " ")
        }catch{
            print(error.localizedDescription)
            return self
        }
    }

    func matchingExpressionNumbers(_ regularExpression: String) -> Int {
        do {
            let regex = try NSRegularExpression(pattern: regularExpression , options: .caseInsensitive)
            return regex.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count))
        }catch{
            print(error.localizedDescription)
            return 0
        }
    }
}

print("\(solution4("Muzi", ["<html lang=\"ko\" xml:lang=\"ko\" xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <meta charset=\"utf-8\">\n  <meta property=\"og:url\" content=\"https://careers.kakao.com/interview/list\"/>\n</head>  \n<body>\n<a href=\"https://programmers.co.kr/learn/courses/4673\"></a>#!MuziMuzi!)jayg07con&&\n\n</body>\n</html>", "<html lang=\"ko\" xml:lang=\"ko\" xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <meta charset=\"utf-8\">\n  <meta property=\"og:url\" content=\"https://www.kakaocorp.com\"/>\n</head>  \n<body>\ncon%\tmuzI92apeach&2<a href=\"https://hashcode.co.kr/tos\"></a>\n\n\t^\n</body>\n</html>"]))")

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

func solution6(_ N:Int, _ stages:[Int]) -> [Int] {
    let stage = Array<Int>(1...N)
    var failArray = [Double]()

    for i in 1...N {
        let havin = stages.filter { i <= $0 }
        failArray.append(Double(havin.filter { i == $0 }.count) / Double(havin.filter { i < $0 }.count))
    }
    failArray += Array([Double](repeating: 0.0, count: N - ((stages.max() ?? N) - 1)))

    return stage.sorted{ failArray[($0-1)] > failArray[($1-1)] }
}

print("\(solution6(5, [3, 5, 5, 5, 6, 4, 3, 3]))")

func solution7(_ words:[String], _ queries:[String]) -> [Int] {
    var score = [Int]()

    for i in 0..<queries.count {
        if let index = queries[0..<i].firstIndex(of: queries[i]) {
            print("\(index)")
            score.append(score[index])
            continue
        }

        let arr = Array(queries[i])
        if !queries[i].contains("?")
            || queries[i].matchingExpression(#"[^{a-z}?]"#)
            || (0 < (arr.firstIndex(of: "?") ?? 0) && (arr.lastIndex(of: "?") ?? (arr.count - 1)) < (arr.count - 1))
            || (0 == (arr.firstIndex(of: "?") ?? 0) && (arr.lastIndex(of: "?") ?? (arr.count - 1)) == (arr.count - 1)) {
            score.append(0)
            continue
        }

        var wordPattern = "\(queries[i].split(separator: "?").reduce(""){$0+$1})"
        let countPattern = #"(.[a-z]{"#+"\(queries[i].count - wordPattern.count - 1)"+#"})"#
        wordPattern = (Array(queries[i]).firstIndex(of: "?") ?? 0) == 0 ? countPattern + wordPattern : wordPattern + countPattern

        var sum = 0
        for word in words {
            if word.count == queries[i].count && word.matchingExpression(wordPattern) {
                sum += 1
            }
        }
        score.append(sum)
    }

    return score
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


print("\(solution7(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "????o", "fr???", "fro???", "pro?", "fro??", "f?ro??"]))")


func solution1(_ board:[[Int]], _ moves:[Int]) -> Int {
    var boards = board
    var stack = [Int]()
    var cnt = 0
    
    for item in moves {
        let move = item - 1
        if move < 0 || move > boards.count { continue }
        
        var doll = 0
        dolWhile : while doll == 0 {
            if boards[move].count == 0 { break dolWhile }
            doll = boards[move][boards[move].endIndex-1]
            boards[move].remove(at: boards[move].endIndex-1)
        }
        if boards[move].count == 0 { continue }
        
        if stack.count > 0 && stack[stack.endIndex-1] == doll {
            stack.remove(at: stack.endIndex-1)
            cnt += 2
            continue
        }
        stack.append(doll)
    }
    
    return cnt
}

print("\(solution1([[0,0,0,0,0],[1,0,3,0,3],[0,2,5,0,1],[4,2,4,4,2],[3,5,1,3,1]], [1,5,3,5,1,2,1,4,5]))")



func solution2(_ s:String) -> [Int] {
    var arr = Array(s)
    arr.remove(at: 0)
    arr.remove(at: arr.endIndex - 1)

    var elementArr = [[Int]]()
    var result = [Int]()

    while true {
        if arr.count <= 0 { break }
        var element = arr[(arr.firstIndex(of: "{")!)..<(arr.firstIndex(of: "}")!) + 1]
        arr.removeSubrange((arr.startIndex)..<(arr.firstIndex(of: "}")!) + 1)

        element.remove(at: element.startIndex)
        element.remove(at: element.endIndex - 1)

        let numbers = String(element).split(separator: ",")

        var elements = [Int]()
        for num in numbers {
            elements.append((String(num) as NSString).integerValue)
        }
        elementArr.append(elements)
    }

    elementArr.sort { $0.count < $1.count }
    for elements in elementArr {
        for element in elements {
            if !result.contains(element) {
                result.append(element)
            }
        }
    }

    return result
}

print("\(solution2("{{4,2,3},{3},{2,3,4,1},{2,3}}"))")



func solution3(_ user_id:[String], _ banned_id:[String]) -> Int {
    let banneds = Array(Set(banned_id))
    var warnList = [Warn]()
    var result = [Int]()

    for banned in banneds {
        let cnt = banned_id.filter { $0 == banned }.count
        let idPattern = banned.replacingOccurrences(of: "*", with: "[a-z0-9]{1}")

        var warn = [String]()
        for user in user_id {
            if user.count == banned.count && user.matchingExpression(idPattern) {
                warn.append(user)
            }
        }
        warnList.append(Warn(id: warn, cnt: cnt))
    }

    for warn in warnList {
        let r = warn.cnt
        let n = warn.id.count

//        if(n == r || r == 0){ result.append(1) }
//        else { result.append(n / (r * (n - r))) }
        arr
        combination(&arr, index, n, r, target + 1)
        result.append(arr.count)
    }

    return result.reduce(1){$0 * $1}
}

struct Warn {
    var id: [String]
    var cnt: Int
}

func combination(arr: inout [Int], index: Int, n: Int, r: Int, target: Int) {
    if (r == 0){ print(arr, index) }
    else if (target == n){ return }
    else {
        arr[index] = target
        combination(&arr, index + 1, n, r - 1, target + 1)
        combination(&arr, index, n, r, target + 1)
    }
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

print("\(solution3(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["fr*d*", "*rodo", "******", "******"]))")



func solution4(_ k:Int64, _ room_number:[Int64]) -> [Int64] {
    var result = [Int64]()

    for number in room_number {
        if number > k { continue }

        if !result.contains(number) {
            result.append(number)
        }
        else {
            var num = number + 1
            while result.contains(num) && num < k {
                num += 1
            }
            result.append(num)
        }
    }

    return result
}

print("\(solution4(10, [1,3,4,1,3,1]))")



func solution5(_ stones:[Int], _ k:Int) -> Int {
    var jinggum = stones.map { $0 - (stones.min() ?? 0) }
    var ninies = stones.min() ?? 0
    
    count : while true {
        var cnt = 1
        stoneFor : for i in (0..<jinggum.count).reversed() {
            if cnt > k {
                break count
            }
            
            if jinggum[i] == 0 {
                cnt += 1
                continue stoneFor
            }
            jinggum[i] -= 1
            cnt = 1
        }
        ninies += 1
    }
    
    return ninies
}

print("\(solution5([2, 4, 5, 3, 2, 1, 4, 2, 5, 1], 3))")
