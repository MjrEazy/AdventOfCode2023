import Foundation

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day11_Test.txt", encoding: String.Encoding.utf8)
do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day11_input.txt", encoding: String.Encoding.utf8)

        var galaxyMap = input.split(separator: "\n").map { Array($0) }

        let emptyRows = galaxyMap.indices.filter { row in
            galaxyMap[row].allSatisfy { char in char == "." }
        }

        let emptyCols = galaxyMap[0].indices.filter { col in
            galaxyMap.allSatisfy { row in row[col] == "." }
        }

        var galaxies: [(Int, Int)] = []
        for (row, line) in galaxyMap.enumerated() {
            for (col, char) in line.enumerated() {
                if char == "#" {
                    galaxies.append((row, col))
                }
            }
        }

        var totalDistance = 0
        for i in 0..<galaxies.count {
            let (galaxyRow, galaxyCol) = galaxies[i]
            for j in 0..<i {
                let (otherGalaxyRow, otherGalaxyCol) = galaxies[j]

                for row in min(otherGalaxyRow, galaxyRow)..<max(otherGalaxyRow, galaxyRow) {
                    totalDistance += emptyRows.contains(row) ? 2 : 1
                }

                for col in min(otherGalaxyCol, galaxyCol)..<max(otherGalaxyCol, galaxyCol) {
                    totalDistance += emptyCols.contains(col) ? 2 : 1
                }
            }
        }

        print(totalDistance)

} catch { print ("file not found") }
