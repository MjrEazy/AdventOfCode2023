import Foundation

func loadFileAsInts(file: String) -> [[Int]] {
    do { let input =  try String(contentsOfFile: file, encoding: String.Encoding.utf8)
        return input.components(separatedBy: "\n").compactMap { row in
            row.components(separatedBy: " ").compactMap { Int($0) }
        }
    } catch {
        print ("File not found")
        return []
    }
}

func getNextNumber(sequence: [Int]) -> Int {
    if Set(sequence).count == 1 {
        return sequence[0]
    }
    let nextNumber = getNextNumber(sequence: zip(sequence, sequence.dropFirst()).map { $1 - $0 })
    return sequence.last! + nextNumber
}

//let input = loadFileAsInts(file: "/Users/David/Projects/AoC23/inputs/Day9_Test.txt")
let input = loadFileAsInts(file: "/Users/David/Projects/AoC23/inputs/Day9_input.txt")
//print (input)

let result = input.reduce(0) { $0 + getNextNumber(sequence: $1.reversed()) }
print(result)

