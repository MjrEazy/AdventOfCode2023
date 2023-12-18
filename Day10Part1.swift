import Foundation

// I keep messing up with strings and characters, so add an extension to String to get a character
extension String {
    func character(at index: Int) -> Character? {
        guard index >= 0 && index < count else { return nil }
        return self[self.index(self.startIndex, offsetBy: index)]
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

    func initialDirection(from start: (Int, Int)) -> (Int, Int) {
        let expectedAdjacentChars: [((Int, Int), String)] = [
            (N, "|7F"),
            (S, "|LJ"),
            (E, "-7J"),
            (W, "-LF")
        ]
        
        for (direction, expectedChars) in expectedAdjacentChars {
            let (x, y) = move(from: start, to: direction)
            if let char = inputLines[y].character(at: x), expectedChars.contains(char) {
                return direction
            }
        }
        
        fatalError("Initial direction not found.")
    }

    let inputLines = input.components(separatedBy: "\n")
    var graph: [String: ((Int, Int), (Int, Int))] = [:]
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

    let (initialX, initialY) = start ?? (0, 0)
    var currentCoords = move(from: (initialX, initialY), to: initialDirection(from: (initialX, initialY)))
    var visited: Set<String> = [("\(initialX),\(initialY)")]

    while true {
        visited.insert("\(currentCoords.0),\(currentCoords.1)")
        let possibleDirections = graph["\(currentCoords.0),\(currentCoords.1)"] ?? ((0, 0), (0, 0))
        let (possibleDirection1, possibleDirection2) = possibleDirections
        let unvisitedNeighbors = [possibleDirection1, possibleDirection2].filter { direction in
            let neighbor = move(from: currentCoords, to: direction)
            return !visited.contains("\(neighbor.0),\(neighbor.1)")
        }
        if unvisitedNeighbors.isEmpty {
            break
        }
        
        currentCoords = move(from: currentCoords, to: unvisitedNeighbors[0])
    }

    print(visited.count / 2)
    
} catch { print ("file not found") }
