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
    var copies: Int
    
    init(id: Int, winningNumbers: [Int], myNumbers: [Int]) {
        self.id = id
        self.winningNumbers = winningNumbers
        self.myNumbers = myNumbers
        self.copies = 1
    }
}

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day4_Test.txt", encoding: String.Encoding.utf8)
do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day4_input.txt", encoding: String.Encoding.utf8)
    let inputCards = input.split(separator: "\n")

    var totalCards: Int = 0
    var cards = Array<Card>()
    
    for inputCard in inputCards {
        let s = inputCard.split(separator: ":")
        let id: Int = Int(String(s[0]).replacing("Card", with: "").trimmingCharacters(in: CharacterSet.whitespaces))!
        let data = inputCard.split(separator: ":")[1].split(separator: "|")
        var array = data[0].trimmingCharacters(in: CharacterSet.whitespaces).components(separatedBy: " ")
        let winners: [Int] = array.compactMap { Int($0) }
        array = data[1].trimmingCharacters(in: CharacterSet.whitespaces).components(separatedBy: " ")
        let numbers: [Int] = array.compactMap { Int($0) }
        let card: Card = Card(id: Int(id), winningNumbers: winners, myNumbers: numbers)
        cards.append(card)
    }
    
//    print (cards)
    
    for i in 0...cards.count - 1 {
        var wins = 0
        for number in cards[i].myNumbers {
            if cards[i].winningNumbers.contains(number) {
                wins += 1
                cards[cards[i].id + wins - 1].copies += cards[i].copies
            }
        }
        totalCards += cards[i].copies
//        print (cards[i])
    }
    print (totalCards)
    
} catch { print ("file not found") }
