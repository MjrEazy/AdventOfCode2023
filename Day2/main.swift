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
input = input.replacingOccurrences(of: ":", with: "")
input = input.replacingOccurrences(of: ",", with: "")
input = input.replacingOccurrences(of: ";", with: "")

var games = input.split(separator: "\n")

var sumCubes = 0

for game in games {
    //print (game)
    var cubes = [String: Int]()
    cubes["red"] = 0
    cubes["blue"] = 0
    cubes["green"] = 0
    let values : [String] = game.components(separatedBy: " ")
    let gameId : Int = Int(values[1])!
    var validGame = true
    for i in 2 ..< values.count {
        //print (values[i])
        if values[i] == "red" { if Int(values[i-1])! > cubes["red"]! { cubes["red"] = Int(values[i-1]) } }
        if values[i] == "green" { if Int(values[i-1])! > cubes["green"]! { cubes["green"] = Int(values[i-1]) } }
        if values[i] == "blue" { if Int(values[i-1])! > cubes["blue"]! { cubes["blue"] = Int(values[i-1]) } }
    }
    sumCubes += Int(cubes["red"]! * cubes["green"]! * cubes["blue"]!)
    print (Int(gameId), Int(cubes["red"]!), Int(cubes["green"]!), Int(cubes["blue"]!))
}

print (sumCubes)
