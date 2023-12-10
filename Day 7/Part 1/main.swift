import Foundation

enum CamelCardsHand: Int, Comparable {
    case highCard, onePair, twoPair, threeOfAKind, fullHouse, fourOfAKind, fiveOfAKind
    
    static func < (lhs: CamelCardsHand, rhs: CamelCardsHand) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

struct Hand: Hashable {
    let cards: String
    let bid: Int
    var values: [Int]
    var rank: CamelCardsHand
    
    init(cards: String, bid: Int) {
        self.cards = cards
        self.bid = bid
        self.values = [0, 0, 0, 0, 0]
        for i in 0...cards.count - 1 {
            let card = self.cards[cards.index(self.cards.startIndex, offsetBy: i)]
            switch(card) {
            case "T":
                self.values[i] = 10
            case "J":
                self.values[i] = 11
            case "Q":
                self.values[i] = 12
            case "K":
                self.values[i] = 13
            case "A":
                self.values[i] = 14
            default:
                self.values[i] = Int(String(card))!
            }
        }
        self.rank = findRank(cards: self.values)
    }
}

func findNOfAKind(_ values: [Int], n: Int, excluding: Int? = nil) -> Int? {
    let valueCounts = values.reduce(into: [:]) { $0[$1, default: 0] += 1 }
    for (value, count) in valueCounts {
        if count == n && value != excluding {
            return value
        }
    }
    return nil
}

func findRank(cards: [Int]) -> CamelCardsHand {
    
    if let fiveOfAKindValue = findNOfAKind(cards, n: 5) {
        return .fiveOfAKind
    }

    if let fourOfAKindValue = findNOfAKind(cards, n: 4) {
        return .fourOfAKind
    }
    
    if let threeOfAKindValue = findNOfAKind(cards, n: 3) {
        if let _ = findNOfAKind(cards, n: 2) {
            return .fullHouse
        } else {
            return .threeOfAKind
        }
    }
    
    if let pairValue1 = findNOfAKind(cards, n: 2), let _ = findNOfAKind(cards, n: 2, excluding: pairValue1) {
        return .twoPair
    }
    
    if let pairValue = findNOfAKind(cards, n: 2) {
        return .onePair
    }
    
    return .highCard
}

func sortHands(_ hands: [Hand]) -> [Hand] {
    return hands.sorted { hand1, hand2 in
        let rank1 = hand1.rank
        let rank2 = hand2.rank
        if rank1 == rank2 {
            if hand1.values[0] != hand2.values[0] {
                if hand1.values[0] > hand2.values[0] {
                    return false
                } else {
                    return true
                }
            }
            if hand1.values[1] != hand2.values[1] {
                if hand1.values[1] > hand2.values[1] {
                    return false
                } else {
                    return true
                }
            }
            if hand1.values[2] != hand2.values[2] {
                if hand1.values[2] > hand2.values[2] {
                    return false
                } else {
                    return true
                }
            }
            if hand1.values[3] != hand2.values[3] {
                if hand1.values[3] > hand2.values[3] {
                    return false
                } else {
                    return true
                }
            }
            if hand1.values[4] != hand2.values[4] {
                if hand1.values[4] > hand2.values[4] {
                    return false
                } else {
                    return true
                }
            }
        }
        return rank1 <= rank2
    }
}

//do { let input = try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day7_Test.txt", encoding: String.Encoding.utf8)
do { let input =  try String(contentsOfFile: "/Users/David/Projects/AoC23/inputs/Day7_input.txt", encoding: String.Encoding.utf8)
    
    var hands: [Hand] = []
    
    let inputHands = input.split(separator: "\n")
    for inputHand in inputHands {
        let data = inputHand.split(separator: " ")
        let hand: Hand = Hand(cards: String(data[0]), bid: Int(data[1])!)
        hands.append(hand)
    }

    let sortedHands: [Hand] = sortHands(hands)

    var i: Int = 1
    var winnings: Int = 0

    for hand in sortedHands {
        winnings += hand.bid * i
        i += 1
    }

    print (sortedHands)
    print (winnings)
    
} catch { print ("file not found") }
