//: Playground - noun: a place where people can play

import UIKit

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
    
    func matchingReplace(_ regularExpression: String, with: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: regularExpression , options: .caseInsensitive)
            return regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count), withTemplate: with)
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

func kakao_solution1(_ board:[[Int]], _ moves:[Int]) -> Int {
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

print("\(kakao_solution1([[0,0,0,0,0],[1,0,3,0,3],[0,2,5,0,1],[4,2,4,4,2],[3,5,1,3,1]], [1,5,3,5,1,2,1,4,5]))")



func kakao_solution2(_ s:String) -> [Int] {
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

print("\(kakao_solution2("{{4,2,3},{3},{2,3,4,1},{2,3}}"))")



func kakao_solution3(_ user_id:[String], _ banned_id:[String]) -> Int {
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
        if(n == r || r == 0){ result.append(1) }
        else { result.append(n / (r * (n - r))) }
    }
    
    return result.reduce(1){$0 * $1}
}

struct Warn {
    var id: [String]
    var cnt: Int
}


print("\(kakao_solution3(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["fr*d*", "*rodo", "******", "******"]))")



func kakao_solution4(_ k:Int64, _ room_number:[Int64]) -> [Int64] {
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

print("\(kakao_solution4(10, [1,3,4,1,3,1]))")



func kakao_solution5(_ stones:[Int], _ k:Int) -> Int {
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

print("\(kakao_solution5([2, 4, 5, 3, 2, 1, 4, 2, 5, 1], 3))")
