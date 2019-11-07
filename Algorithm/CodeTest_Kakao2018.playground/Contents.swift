import Foundation

/*비밀지도
 네오는 평소 프로도가 비상금을 숨겨놓는 장소를 알려줄 비밀지도를 손에 넣었다. 그런데 이 비밀지도는 숫자로 암호화되어 있어 위치를 확인하기 위해서는 암호를 해독해야 한다. 다행히 지도 암호를 해독할 방법을 적어놓은 메모도 함께 발견했다.
 
 지도는 한 변의 길이가 n인 정사각형 배열 형태로, 각 칸은 공백(" ) 또는벽(#") 두 종류로 이루어져 있다.
 전체 지도는 두 장의 지도를 겹쳐서 얻을 수 있다. 각각 지도 1과 지도 2라고 하자. 지도 1 또는 지도 2 중 어느 하나라도 벽인 부분은 전체 지도에서도 벽이다. 지도 1과 지도 2에서 모두 공백인 부분은 전체 지도에서도 공백이다.
 지도 1과 지도 2는 각각 정수 배열로 암호화되어 있다.
 암호화된 배열은 지도의 각 가로줄에서 벽 부분을 1, 공백 부분을 0으로 부호화했을 때 얻어지는 이진수에 해당하는 값의 배열이다.
 secret map
 
 네오가 프로도의 비상금을 손에 넣을 수 있도록, 비밀지도의 암호를 해독하는 작업을 도와줄 프로그램을 작성하라.
 
 입력 형식
 입력으로 지도의 한 변 크기 n 과 2개의 정수 배열 arr1, arr2가 들어온다.
 
 1 ≦ n ≦ 16
 arr1, arr2는 길이 n인 정수 배열로 주어진다.
 정수 배열의 각 원소 x를 이진수로 변환했을 때의 길이는 n 이하이다. 즉, 0 ≦ x ≦ 2n - 1을 만족한다.
 출력 형식
 원래의 비밀지도를 해독하여 '#', 공백으로 구성된 문자열 배열로 출력하라.
 */

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


/*다트 게임
 카카오톡에 뜬 네 번째 별! 심심할 땐? 카카오톡 게임별~
 
 Game Star
 
 카카오톡 게임별의 하반기 신규 서비스로 다트 게임을 출시하기로 했다. 다트 게임은 다트판에 다트를 세 차례 던져 그 점수의 합계로 실력을 겨루는 게임으로, 모두가 간단히 즐길 수 있다.
 갓 입사한 무지는 코딩 실력을 인정받아 게임의 핵심 부분인 점수 계산 로직을 맡게 되었다. 다트 게임의 점수 계산 로직은 아래와 같다.
 
 다트 게임은 총 3번의 기회로 구성된다.
 각 기회마다 얻을 수 있는 점수는 0점에서 10점까지이다.
 점수와 함께 Single(S), Double(D), Triple(T) 영역이 존재하고 각 영역 당첨 시 점수에서 1제곱, 2제곱, 3제곱 (점수1 , 점수2 , 점수3 )으로 계산된다.
 옵션으로 스타상(*) , 아차상(#)이 존재하며 스타상(*) 당첨 시 해당 점수와 바로 전에 얻은 점수를 각 2배로 만든다. 아차상(#) 당첨 시 해당 점수는 마이너스된다.
 스타상(*)은 첫 번째 기회에서도 나올 수 있다. 이 경우 첫 번째 스타상(*)의 점수만 2배가 된다. (예제 4번 참고)
 스타상(*)의 효과는 다른 스타상(*)의 효과와 중첩될 수 있다. 이 경우 중첩된 스타상(*) 점수는 4배가 된다. (예제 4번 참고)
 스타상(*)의 효과는 아차상(#)의 효과와 중첩될 수 있다. 이 경우 중첩된 아차상(#)의 점수는 -2배가 된다. (예제 5번 참고)
 Single(S), Double(D), Triple(T)은 점수마다 하나씩 존재한다.
 스타상(*), 아차상(#)은 점수마다 둘 중 하나만 존재할 수 있으며, 존재하지 않을 수도 있다.
 0~10의 정수와 문자 S, D, T, *, #로 구성된 문자열이 입력될 시 총점수를 반환하는 함수를 작성하라.
 
 입력 형식
 점수|보너스|[옵션]으로 이루어진 문자열 3세트.
 예) 1S2D*3T
 
 점수는 0에서 10 사이의 정수이다.
 보너스는 S, D, T 중 하나이다.
 옵선은 *이나 # 중 하나이며, 없을 수도 있다.
 출력 형식
 3번의 기회에서 얻은 점수 합계에 해당하는 정수값을 출력한다.
 예) 37*/

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
