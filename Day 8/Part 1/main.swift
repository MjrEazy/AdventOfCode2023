import Foundation

func countSteps(_ instructions: String, _ network: [String: (String, String)], _ startLocation: String) -> Int {
    var stepCounter = 0
    var instructionIndex = 0
    var currentLocation = startLocation
    // print (currentLocation)
    while currentLocation != "ZZZ" {
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
    
    var solution = 0
    let startLocation = "AAA"
    solution = countSteps(instructions, network, startLocation)
    print(solution)

}

