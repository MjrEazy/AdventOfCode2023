//
//  main.swift
//  Aoc23
//
//  Created by David on 05/12/2023.
//

import Foundation

func lookup(val: Int, map: String) -> Int {
    let ranges = map.components(separatedBy: "\n").dropFirst()
    for range in ranges {
        if !range.isEmpty {
            let components = range.split(separator: " ").map { Int($0)! }
            let destination = components[0]
            let source = components[1]
            let rangeLen = components[2]
            if source <= val && val < (source + rangeLen) {
                return val + (destination - source)
            }
        }
    }
    return val
}

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day5_Test.txt", encoding: String.Encoding.utf8)
do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day5_input.txt", encoding: String.Encoding.utf8)

    let almanac = input.components(separatedBy: "\n\n")
    let seeds = almanac[0]
    let maps = almanac[1...]
    let seedMap = seeds.split(separator: " ")[1...].map { Int($0)! }
    let result = seedMap.reduce(0) { (acc, seed) in
            maps.reduce(seed) { (current, map) in lookup(val: current, map: map) }
    }
    print(result)

} catch { print ("file not found") }
