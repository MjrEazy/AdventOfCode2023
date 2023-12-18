import Foundation

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day15_Test.txt", encoding: String.Encoding.utf8)
do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day15_input.txt", encoding: String.Encoding.utf8)
    print(input)
    var total = 0
    for step in input.split(separator: ",") {
        print(step)
        var currentVal = 0
        for char in step {
            currentVal += Int(char.asciiValue!)
            currentVal *= 17
            currentVal %= 256
        }
        total += currentVal
    }
    print(total)
    
} catch { print ("file not found") }
