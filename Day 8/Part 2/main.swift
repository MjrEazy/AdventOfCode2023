import Foundation

// Helper function to calculate the greatest common divisor
func gcd(_ a: Int, _ b: Int) -> Int {
    return b == 0 ? a : gcd(b, a % b)
}

// Helper function to calculate the least common multiple
func lcm(_ a: Int, _ b: Int) -> Int {
    return a * b / gcd(a, b)
}

func countSteps(_ instructions: String, _ network: [String: (String, String)], _ startLocation: String) -> Int {
    var stepCounter = 0
    var instructionIndex = 0
    var currentLocation = startLocation
    // print (currentLocation)
    while !currentLocation.hasSuffix("Z") {
        let direction = Int(String(instructions[instructions.index(instructions.startIndex, offsetBy: instructionIndex)])) ?? 0
        if direction == 0 {
            currentLocation = network[currentLocation]?.0 ?? ""
        } else {
            currentLocation = network[currentLocation]?.1 ?? ""
        }
        // print (currentLocation)
        stepCounter += 1

        instructionIndex += 1
        if instructionIndex > instructions.count - 1 {
            instructionIndex = 0
        }
    }
    
    return stepCounter
}

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day8_Test.txt", encoding: String.Encoding.utf8)
//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day8_Test2.txt", encoding: String.Encoding.utf8)
do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day8_input.txt", encoding: String.Encoding.utf8)
    
    let lines = input.components(separatedBy: "\n")
    let instructions = lines[0].replacingOccurrences(of: "L", with: "0").replacingOccurrences(of: "R", with: "1")
    var network = [String: (String, String)]()
    
    for line in lines[2...] {
        if !line.isEmpty {
            let parts = line.components(separatedBy: " = ")
            let node = parts[0]
            let leftNode = parts[1].components(separatedBy: ", ")[0].dropFirst()
            let rightNode = parts[1].components(separatedBy: ", ")[1].dropLast()
            network[node] = (String(leftNode), String(rightNode))
        }
    }
    
    var solution = 1
    for start in network.keys {
        if start.hasSuffix("A") {
            let startLocation = start
            solution = lcm(solution, countSteps(instructions, network, startLocation))
        }
    }
    
    print(solution)
    
} catch { print ("file not found") }

