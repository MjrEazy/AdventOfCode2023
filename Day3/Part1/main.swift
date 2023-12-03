//
//  main.swift
//  Aoc23
//
//  Created by David on 02/12/2023.
//
// I know regex! Stil learning Swift and couldn't get the regex to work, didn't like the regex metacharacters, need to read more so brute forced it...

import Foundation
import Cocoa

private func checkChar(char: String) -> Bool {
    if char.contains("@") { return true }
    if char.contains("+") { return true }
    if char.contains("=") { return true }
    if char.contains("*") { return true }
    if char.contains("/") { return true }
    if char.contains("-") { return true }
    if char.contains("#") { return true }
    if char.contains("&") { return true }
    if char.contains("%") { return true }
    if char.contains("!") { return true }
    if char.contains("$") { return true }
    return false
}

private func checkRow(row: String, r: Int, c1: Int, c: Int) -> Bool {
    
    var isValidPart: Bool = false
    var char = "."
    for i in c1...c - 1 {
        if i > 0 && !isValidPart {
            char = String(row[row.index(row.startIndex, offsetBy: Int(i - 1))])
            isValidPart = checkChar(char: char)
        }
        if i < row.count - 1 && !isValidPart {
            char = String(row[row.index(row.startIndex, offsetBy: Int(i + 1))])
            isValidPart = checkChar(char: char)
        }
    }
    if !isValidPart {
        char = String(row[row.index(row.startIndex, offsetBy: Int(c1))])
        isValidPart = checkChar(char: char)
    }
    return isValidPart
}

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day3_Test1.txt", encoding: String.Encoding.utf8)
do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day3_input.txt", encoding: String.Encoding.utf8)
let rows = input.split(separator: "\n")

var r: Int = 0

var sumPartNums : Int = 0

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
                sumPartNums += partNum
            }
        }
        c += 1
    }
    r += 1
}

print (sumPartNums)

} catch { print ("file not found") }
