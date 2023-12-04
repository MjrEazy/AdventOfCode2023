//
//  main.swift
//  Aoc23
//
//  Created by David on 02/12/2023.
//

import Foundation

struct Card: Hashable {
    let id: Int
    let winningNumbers: [Int]
    let myNumbers: [Int]
    var points: Int
    
    init(id: Int, winningNumbers: [Int], myNumbers: [Int]) {
        self.id = id
        self.winningNumbers = winningNumbers
        self.myNumbers = myNumbers
        self.points = 0
    }
}

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day4_Test.txt", encoding: String.Encoding.utf8)
do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day4_input.txt", encoding: String.Encoding.utf8)
    let cards = input.split(separator: "\n")

    var totalPoints: Int = 0
        
    for inputCard in cards {
        let s = inputCard.split(separator: ":")
        let id: Int = Int(String(s[0]).replacing("Card", with: "").trimmingCharacters(in: CharacterSet.whitespaces))!
        var data = inputCard.split(separator: ":")[1].split(separator: "|")
        var array = data[0].trimmingCharacters(in: CharacterSet.whitespaces).components(separatedBy: " ")
        var winners: [Int] = array.compactMap { Int($0) }
        array = data[1].trimmingCharacters(in: CharacterSet.whitespaces).components(separatedBy: " ")
        var numbers: [Int] = array.compactMap { Int($0) }
        var card: Card = Card(id: Int(id), winningNumbers: winners, myNumbers: numbers)
        for number in card.myNumbers {
            for winner in card.winningNumbers {
                if number == winner {
                    if card.points == 0 { card.points = 1 } else { card.points *= 2 }
                }
            }
        }
        totalPoints += card.points
        print (card)
    }
    print (totalPoints)
    
} catch { print ("file not found") }
