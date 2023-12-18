import Foundation

// I keep messing up with strings and characters, so add an extension to String to get a character
extension String {
    func character(at index: Int) -> Character? {
        guard index >= 0 && index < count else { return nil }
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

let N = (0, -1)
let S = (0, 1)
let E = (1, 0)
let W = (-1, 0)

let directionMappings: [Character: ((Int, Int), (Int, Int))] = [
    "|": (N, S),
    "-": (E, W),
    "L": (N, E),
    "J": (N, W),
    "7": (S, W),
    "F": (S, E)
]

func move(from coordinates: (Int, Int), to direction: (Int, Int)) -> (Int, Int) {
    return (coordinates.0 + direction.0, coordinates.1 + direction.1)
}

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day10_Test.txt", encoding: String.Encoding.utf8)
//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day10_Test2.txt", encoding: String.Encoding.utf8)
do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day10_input.txt", encoding: String.Encoding.utf8)


    var inputLines = input.components(separatedBy: "\n")
    var graph: [String: ((Int, Int), (Int, Int))] = [:]  // of directions per coordinate
    var start: (Int, Int)?

    for (y, line) in inputLines.enumerated() {
        for (x, char) in line.enumerated() {
            if "|-LJ7F".contains(char) {
                graph["\(x),\(y)"] = directionMappings[char]
            }
            if char == "S" {
                start = (x, y)
            }
        }
    }

    func initialDirectionOptions(from start: (Int, Int)) -> [(Int, Int)] {
        var options: [(Int, Int)] = []
        let expectedAdjacentChars: [((Int, Int), String)] = [
            (N, "|7F"),
            (S, "|LJ"),
            (E, "-7J"),
            (W, "-LF")
        ]
        for direction in [N, S, E, W] {
            let (x, y) = move(from: start, to: direction)  // skipping boundary checks
            if let char = inputLines[safe: y]?[safe: x], expectedAdjacentChars.contains(where: { $0.0 == direction && $0.1.contains(char) }) {
                options.append(direction)
            }
        }
        return options
    }

    var (initialX, initialY) = start ?? (0, 0)
    var currentCoords = move(from: (initialX, initialY), to: initialDirectionOptions(from: (initialX, initialY)).first!)
    var visited: Set<String> = ["\(initialX),\(initialY)"]

    while true {
        visited.insert("\(currentCoords.0),\(currentCoords.1)")
        let possibleDirections = graph["\(currentCoords.0),\(currentCoords.1)"] ?? ((0, 0), (0, 0))
        let unvisitedNeighbors = possibleDirections.filter { direction in
            let neighbor = move(from: currentCoords, to: direction)
            return !visited.contains("\(neighbor.0),\(neighbor.1)")
        }
        
        if unvisitedNeighbors.isEmpty {
            break  // back at start
        }
        
        currentCoords = move(from: currentCoords, to: unvisitedNeighbors[0])
    }

    var isEnclosed = false
    var enclosedTiles = 0
    let (width, height) = (inputLines.first?.count ?? 0, inputLines.count)

    for x in 0..<width {
        for y in 0..<height {
            let isPipe = visited.contains("\(x),\(y)")

            if !isPipe {
                if isEnclosed {
                    enclosedTiles += 1
                }
                continue
            }

            let char = inputLines[safe: y]?[safe: x] ?? " "
            if char == "S" {
                let startOptions = initialDirectionOptions(from: (x, y))
                let startPipeType = directionMappings.first { _, directions in Set(directions) == Set(startOptions) }?.key ?? ""
                let newChar = startPipeType
                if newChar != char {
                    continue
                }
            }

            let isStartingCorner = "F7".contains(char)
            let isEndingCorner = "LJ".contains(char)
            let isHorizontalPipe = char == "-"

            if isHorizontalPipe {
                isEnclosed.toggle()
            } else if isStartingCorner {
                let sourceDirection = (char == "F") ? E : W
            } else if isEndingCorner {
                let targetDirection = (char == "L") ? E : W
                if targetDirection != sourceDirection {
                    isEnclosed.toggle()
                }
            }
        }
    }

    print(enclosedTiles)

} catch { print ("file not found") }
