import Foundation

func findResult(time: Int, dist: Int, left: Bool) -> Int {
    var lo = 0
    var hi = time

    while lo <= hi {
        let mid = lo + (hi - lo) >> 1
        if mid * (time - mid) > dist {
            if left {
                hi = mid - 1
            } else {
                lo = mid + 1
            }
        } else {
            if left {
                lo = mid + 1
            } else {
                hi = mid - 1
            }
        }
    }
    return left ? lo : hi
}

func winners(time: Int, dist: Int) -> Int {
    return findResult(time: time, dist: dist, left: false) - findResult(time: time, dist: dist, left: true) + 1
}

func findRaces(races: [[Int]]) -> Int {
    let timeDist = races.map { race in
        return Int(race.map { String($0) }.joined())!
    }
    return winners(time: timeDist[0], dist: timeDist[1])
}

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day6_Test.txt", encoding: String.Encoding.utf8)
do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day6_input.txt", encoding: String.Encoding.utf8)
    
    let races = input.components(separatedBy: "\n").map { line in
        line.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .compactMap { Int($0) }
    }
    
    print(findRaces(races: races))
    
} catch { print ("file not found") }
