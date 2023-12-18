// Started off thinking about doing a flood fill but after day 10 I remembered that I'd looked at the solutions there for day 10 and they were using shoelace and pick's theorem so decided to look this up and realised I should I use that instead
import Foundation

func shoelaceArea(points: [(Int, Int)]) -> Int {
    let x = points.map { $0.0 }
    let y = points.map { $0.1 }

    var sum1 = 0
    var sum2 = 0

    for i in 0..<x.count {
        sum1 += x[i] * y[(i + 1) % y.count]
        sum2 += y[i] * x[(i + 1) % x.count]
    }

    let area = abs((sum1 - sum2) / 2)
    return area
}

//do { let instructions =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day18_Test.txt", encoding: String.Encoding.utf8)
do { let instructions =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day18_input.txt", encoding: String.Encoding.utf8)
    
    let lines = instructions.components(separatedBy: .newlines).filter { !$0.isEmpty }

    var points = [(0, 0)]
    for line in lines {
        let components = line.split(separator: " ")
        let c = String(components[2])
        
        let p = points.last!
        let d = c.suffix(2)
        let length = Int(c.dropFirst(2).dropLast(2), radix: 16)!
        
        switch d {
            case "3)":
                points.append((p.0 - length, p.1))
            case "1)":
                points.append((p.0 + length, p.1))
            case "0)":
                points.append((p.0, p.1 + length))
            case "2)":
                points.append((p.0, p.1 - length))
            default: break
        }
    }

    // shoelace formula to calculate area
    let a = shoelaceArea(points: points)
    
    let c = lines.map { Int($0.split(separator: " ")[2].dropFirst(2).dropLast(2), radix: 16)! }
    let b = c.reduce(0, +)

    // pick's theorem
    let i = a - (b / 2) + 1
    print (i + b)

} catch { print ("file not found") }
