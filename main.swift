//
//  main.swift
//  Aoc23
//
//  Created by David on 02/12/2023.
//

import Foundation
import Cocoa

//var input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day2_Test.txt", encoding: String.Encoding.utf8)
var input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day2_input.txt", encoding: String.Encoding.utf8)
let maxRed : Int = 12
let maxBlue : Int = 14
let maxGreen : Int = 13

input = input.replacingOccurrences(of: ":", with: "")
input = input.replacingOccurrences(of: ",", with: "")
input = input.replacingOccurrences(of: ";", with: "")

var games = input.split(separator: "\n")

var sumValid = 0

for game in games {
    //print (game)
    var counts = [String: Int]()
    counts["red"] = 0
    counts["blue"] = 0
    counts["green"] = 0
    let values : [String] = game.components(separatedBy: " ")
    let gameId : Int = Int(values[1])!
    var validGame = true
    for i in 2 ..< values.count {
        //print (values[i])
        if values[i] == "red" { if Int(values[i-1])! > maxRed { validGame = false } }
        if values[i] == "green" { if Int(values[i-1])! > maxGreen { validGame = false } }
        if values[i] == "blue" { if Int(values[i-1])! > maxBlue { validGame = false } }
    }
    if validGame {
        sumValid += gameId
        print (gameId, counts["red"], counts["green"], counts["blue"])
    }
}

print (sumValid)
