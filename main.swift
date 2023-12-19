import Foundation

func product<T>(_ array: [T], repeat count: Int) -> [[T]] {
    guard count > 0 else { return [[]] }
    return array.flatMap { element in
        product(array, repeat: count - 1).map { [element] + $0 }
    }
}

func readInput(_ input: String) -> [(String, [Int])] {
    var result: [(String, [Int])] = []
    var lastDamages: [Int] = []
    for line in input.components(separatedBy: "\n") {
        let components = line.components(separatedBy: " ")
        if components.count == 2 {
            let records = components[0]
            let damages = components[1].split(separator: ",").compactMap { Int($0) }
            lastDamages = damages
            result.append((records, damages))
        } else {
            let records = components[0]
            result.append((records, lastDamages))
        }
    }
    return result
}

func possibleMatches(_ s: String) -> [String] {
    let x = s.filter { $0 == "?" }.count
    let combinations = product([".", "#"], repeat: x)
    return combinations.map { filler in
        var n = s
        for c in filler {
            if let index = n.firstIndex(of: "?") {
                n.replaceSubrange(index...index, with: String(c))
            }
        }
        return n
    }
}

func makeRegex(_ damages: [Int]) -> NSRegularExpression? {
    let regexString = damages.map { "[#]{\($0)}" }.joined(separator: "[.]+")
    let regexPattern = "^[.]*\(regexString)[.]*$"
    return try? NSRegularExpression(pattern: regexPattern)
}

func matches(record: String, damages: [Int]) -> Int {
    var count = 0
    if let regex = makeRegex(damages) {
        for poss in possibleMatches(record) {
            let range = NSRange(location: 0, length: poss.utf8.count)
            let matches = regex.matches(in: poss, options: [], range: range)
            if matches.count == 1 {
                count += 1
            }
        }
    }
    return count
}

//do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day12_Test.txt", encoding: String.Encoding.utf8)
do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day12_input.txt", encoding: String.Encoding.utf8)
    
    let data = readInput(input)
    var result = 0
    for (record, damages) in data {
        result += matches(record: record, damages: damages)
    }
    print (result)

} catch { print ("file not found") }
