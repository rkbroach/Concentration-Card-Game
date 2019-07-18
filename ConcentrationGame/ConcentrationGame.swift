//
//  ConcentrationGame.swift
//  ConcentrationGame
//
//  Created by Rohan Kevin Broach on 6/7/19.
//  Copyright © 2019 rkbroach. All rights reserved.
//

import Foundation // ??

class ConcentrationGame {
    
    private(set) var cards = [Card]() // Empty Array, other classes can get, but only this class can set.
    
    // Create a deck of cards
    init (numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "ConcentrationGame.init(\(numberOfPairsOfCards)): You must have at least one pair of cards") // read more about assert
        
        // add all pairs of Card objects to the deck
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] // same cards added as a pair
        }
        // TODO : Shuffle the cards
    }
    
    // Card touched (event) in UI
    func chooseCard (at index: Int) {
        
        assert(cards.indices.contains(index), "Concentration.chooseCard (at: \(index) chosen index is not in the cards")
        
        if cards[index].isMatched == false { // card you chose has not been matched yet
            if let matchIndex = indexOfOneFaceUpCard, matchIndex != index { // card to be checked for match | 2nd if is if same card is tapped again
                if cards[matchIndex] == cards[index] { // matched | it implements Hashable and Equatable
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                
            } else {
                // either no cards or both cards are face up
                indexOfOneFaceUpCard =  index
            }
        }
    }
    
    private var indexOfOneFaceUpCard : Int? {
        get {
            return (cards.indices.filter { cards[$0].isFaceUp }).oneAndOnly // closure and extension  of Collection Protocol

//            var foundIndex : Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    // first face up card
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        // second face up card
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        
        set  {
            for index in cards.indices {
             
                cards[index].isFaceUp = (index == newValue) // newValue is val received by get, and .isFaceUp is set to true | else always false
            }
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
