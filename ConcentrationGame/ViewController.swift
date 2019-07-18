//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Rohan Kevin Broach on 6/7/19.
//  Copyright © 2019 rkbroach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // UI
    @IBOutlet private var cardButtons: [UIButton]!       // ! - forced unwrapping of optional?, @symbol ?
    @IBOutlet private weak var flipCountLabel: UILabel!  // weak (ARC) ?
    
    
    // set up the game
    private lazy var game = ConcentrationGame(numberOfPairsOfCards : numberOfPairsOfCards) // return in a var? | lazy?
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1)/2
    }
    
    // set flip count
    private(set) var count = 0 {
        didSet { // property observer?
            flipCountLabel.text = "Flips: \(count)"
        }
    }
    
    // outlet selection order depends on?
    // Card touched (event) in UI
    @IBAction private func touchCard(_ sender: UIButton) {
        count += 1
        
        let cardNumber = cardButtons.firstIndex(of: sender)! // why ! here | since nil may be returned?
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    // Update View based on Model's Logic
    private func updateViewFromModel () {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    // Array of available emoji choices (16 heres)
    private  var emojiChoices = ["😍","👻","😈","🤖","👹","🐶","🐵","🐸","🐷","🐙","🌝","🍔","⚽️","🚔","🚄","🐇"]

        // TODO: Create theme based emojies
    
    // Dictionary of emojies
    private var emoji = [Card: String]()  // bracket?
    
    // Randomly selects an emoji from available emoji choices and adds it to emoji dictionary
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 1 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.randomGenerator)
        }
        return emoji[card] ??  "?" // return a if not nil, else b   ---->  a ?? b
    }
}

// Generate a random number
extension Int {
    var randomGenerator: Int {
        if (self > 0) {
            return Int(arc4random_uniform(UInt32(self)))
            
        } else if (self < 0) {
            return -Int(arc4random_uniform(UInt32(abs(self))))
            
        } else {
            return 0
        }
    }
}
