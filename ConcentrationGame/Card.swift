//
//  Card.swift
//  ConcentrationGame
// 
//  Created by Rohan Kevin Broach on 6/7/19.
//  Copyright ©  rkbroach. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    // Properties
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    // Create a card
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    // Create unique identifiers for the card
    private static var identifierFactory = 0    // why static?
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    
}
