//
//  main.swift
//  Aoc23
//
//  Created by David on 02/12/2023.
//
// I 've gotta read up on maps, there has to be a better way to do this using maps...

import Foundation
import Cocoa

struct Point: Hashable {
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

struct PartNumber: Hashable {
    let value: Int
    let start: Point
    let length: Int
    
    init(value: Int, start: Point, length: Int) {
        self.value = value
        self.start = start
        self.length = length
    }
}

var gears = Set<Point>()

private func checkChar(char: String, x: Int, y: Int) -> Bool {
    if char.contains("*") {
        gears.insert(Point(x: x, y: y))
        return true
    }
    return false
}

private func checkRow(row: String, r: Int, c1: Int, c: Int) -> Bool {
    
    var isValidPart: Bool = false
    var char = "."
    for i in c1...c - 1 {
        if i > 0 && !isValidPart {
            char = String(row[row.index(row.startIndex, offsetBy: Int(i - 1))])
            isValidPart = checkChar(char: char, x: i-1, y: r)
        }
        if i < row.count - 1 && !isValidPart {
            char = String(row[row.index(row.startIndex, offsetBy: Int(i + 1))])
            isValidPart = checkChar(char: char, x: i+1, y: r)
        }
    }
    if !isValidPart {
        char = String(row[row.index(row.startIndex, offsetBy: Int(c1))])
        isValidPart = checkChar(char: char, x: c1, y: r)
    }
    return isValidPart
}

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day3_Test2.txt", encoding: String.Encoding.utf8)
do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day3_input.txt", encoding: String.Encoding.utf8)
let rows = input.split(separator: "\n")

var r: Int = 0

var partNums = Set<PartNumber>()
    
//print (rows)

for row in rows {
    
    //print ("row: ", r)
    
    var c: Int = 0

    while c < row.count {
        var digits : String = ""
        var char = row[row.index(row.startIndex, offsetBy: c)]
        
        var c1 : Int = -1
        while char.isNumber && c < row.count {
            digits = digits + String(char)
            if c1 == -1 { c1 = c }
            c += 1
            if c < row.count { char = row[row.index(row.startIndex, offsetBy: c)] }
        }
        var isValidPart : Bool = false
        if let partNum = Int(digits) {
            //print (partNum)
            isValidPart = checkRow(row: String(row), r: r, c1: c1, c: c)
            if r > 0 && !isValidPart {
                let rowAbove = rows[rows.index(rows.startIndex, offsetBy: r-1)]
                //print (rowAbove)
                if !isValidPart { isValidPart = checkRow(row: String(rowAbove), r: r-1, c1: c1, c: c) }
            }
            if r < rows.count - 1 && !isValidPart {
                let rowBelow = rows[rows.index(rows.startIndex, offsetBy: r+1)]
                //print (rowBelow)
                if !isValidPart { isValidPart = checkRow(row: String(rowBelow), r: r+1, c1: c1, c: c) }
            }
            if isValidPart {
                //print (partNum)
                partNums.insert(PartNumber(value: partNum, start: Point(x: c1, y: r), length: digits.count))
            }
        }
        c += 1
    }
    r += 1
}

var sumGearRatios: Int = 0

for gear in gears {
    
    var parts = Set<PartNumber>()

    for part in partNums {
        
        if((part.start.x == gear.x + 1 || part.start.x + part.length - 1 == gear.x + 1 || (part.length > 2 && part.start.x + part.length - 2 == gear.x + 1)) && part.start.y == gear.y) {
            parts.insert(part)
        }
        
        if((part.start.x == gear.x + 1 || part.start.x + part.length - 1 == gear.x + 1 || (part.length > 2 && part.start.x + part.length - 2 == gear.x + 1)) && part.start.y == gear.y + 1) {
            parts.insert(part)
        }
        
        if((part.start.x == gear.x || part.start.x + part.length - 1 == gear.x || (part.length > 2 && part.start.x + part.length - 2 == gear.x)) && part.start.y == gear.y + 1) {
            parts.insert(part)
        }
        
        if((part.start.x == gear.x - 1 || part.start.x + part.length - 1 == gear.x - 1 || (part.length > 3 && part.length - 2 == gear.x - 1)) && part.start.y == gear.y + 1) {
            parts.insert(part)
        }
        
        if((part.start.x == gear.x - 1 || part.start.x + part.length - 1 == gear.x - 1 || (part.length > 2 && part.start.x + part.length - 2 == gear.x - 1)) && part.start.y == gear.y) {
            parts.insert(part)
        }
        
        if((part.start.x == gear.x - 1 || part.start.x + part.length - 1 == gear.x - 1) && part.start.y == gear.y - 1) {
            parts.insert(part)
        }
        
        if((part.start.x == gear.x || part.start.x + part.length - 1 == gear.x || (part.length > 2 && part.start.x + part.length - 2 == gear.x)) && part.start.y == gear.y - 1) {
            parts.insert(part)
        }
        
        if((part.start.x == gear.x + 1 || part.start.x + part.length - 1 == gear.x + 1) && part.start.y == gear.y - 1) {
            parts.insert(part)
        }
    }
    if parts.count > 1 {
        print (parts)
        let gearRatio = Int(Array(parts)[0].value * Array(parts)[1].value)
        sumGearRatios += gearRatio
    }
}
print(sumGearRatios)
    
} catch { print ("file not found") }
