import Foundation

// got regex working but only by doing it in Python 1st then copying the regex to my swift code and I'd guess there's a better way of handling the ones with a - where there is no numeric part?

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day15_Test.txt", encoding: String.Encoding.utf8)
do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day15_input.txt", encoding: String.Encoding.utf8)

    var labels = [Int: [String]]()
    var lenses = [Int: [Int]]()
    let regex = try! NSRegularExpression(pattern: "(\\w+)(=|-)(\\d+)?")

    for match in regex.matches(in: input, range: NSRange(input.startIndex..., in: input)) {
        let label = (input as NSString).substring(with: match.range(at: 1))
        let op = (input as NSString).substring(with: match.range(at: 2))
        let focalLenRange = match.range(at: 3)
        var focalLenString: String
        if focalLenRange.location != NSNotFound {
            focalLenString = (input as NSString).substring(with: focalLenRange)
        } else {
            focalLenString = ""
        }

        var hash = 0
        for char in label {
            hash = (hash + Int(char.asciiValue!)) * 17 % 256
        }

        if var labelList = labels[hash], var lensList = lenses[hash] {
            if let index = labelList.firstIndex(of: label) {
                if op == "-" {
                    labelList.remove(at: index)
                    lensList.remove(at: index)
                } else if let focalLen = Int(focalLenString) {
                    lensList[index] = focalLen
                }
                labels[hash] = labelList
                lenses[hash] = lensList
            } else if op == "=", let focalLen = Int(focalLenString) {
                labels[hash]?.append(label)
                lenses[hash]?.append(focalLen)
            }
        } else if op == "=", let focalLen = Int(focalLenString) {
            labels[hash] = [label]
            lenses[hash] = [focalLen]
        }
    }

    var total = 0
    for (box, lensList) in lenses {
        for (i, focalLen) in lensList.enumerated() {
            total += (box + 1) * (i + 1) * focalLen
        }
    }
    print(total)
    
} catch { print ("file not found") }
