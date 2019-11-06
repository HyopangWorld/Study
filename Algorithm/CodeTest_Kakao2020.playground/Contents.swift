import Foundation

func solution(_ s:String) -> Int {
    return solve(input: s, len: 1).count
}

func solve(input :String, len:Int) -> String {
    if len > (input.count / 2) {
        return input
    }

    var count = 0
    var curstr = ""
    var result = ""
    for str in input.split(by: len) {
        if str != curstr {
            result += resultString(input: curstr, count: count)
            curstr = str
            count = 0
        } else {
            count += 1
        }
    }
    result += resultString(input: curstr, count: count)

    let result2 = solve(input: input, len: len+1)
    return min(result, result2)
}

@inline(__always) func resultString(input:String, count:Int) -> String {
    if count > 0 {
        return "\(count + 1)" + input
    }
    return input
}

extension String {
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
}

print(solution("aabbaccc"))
