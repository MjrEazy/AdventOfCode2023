import Foundation

func transpose(matrix: [[Int]]) -> [[Int]] {
    guard !matrix.isEmpty else {
        return matrix
    }

    let rowCount = matrix.count
    let columnCount = matrix[0].count

    var result = [[Int]](repeating: [Int](repeating: 0, count: rowCount), count: columnCount)

    for i in 0..<rowCount {
        for j in 0..<columnCount {
            result[j][i] = matrix[i][j]
        }
    }

    return result
}

func binarySearch(time: Int, dist: Int, left: Bool) -> Int {
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
    return binarySearch(time: time, dist: dist, left: false) - binarySearch(time: time, dist: dist, left: true) + 1
}


//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day6_Test.txt", encoding: String.Encoding.utf8)
do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day6_input.txt", encoding: String.Encoding.utf8)
    
    let races = input
        .components(separatedBy: "\n")
        .map { line in
            line
                .components(separatedBy: CharacterSet.decimalDigits.inverted)
                .compactMap { Int($0) }
        }
    print (races)
    let transposedRaces = transpose(matrix: races)


    print (transposedRaces)
    let result = transposedRaces.reduce(1) { acc, race in
        acc * winners(time: race[0], dist: race[1])
    }
    
    print("Part 1: \(result)")

} catch { print ("file not found") }
