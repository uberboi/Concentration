//
//  ViewController.swift
//  Concentration
//
//  Created by Steven Huang on 9/1/18.
//  Copyright © 2018 Steven Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Identifiers don't reset
    //Run out of emojis in dictionary
    @IBAction private func newGame(_ sender: UIButton) {
        print("New Game")
        print(emoji)
        //Game is set to newly intialized Concentration() and view is updated
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emojiChoices = getEmojiChoices()
        emoji.removeAll()
        updateViewFromModel()
    }
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    
    private var emojiChoices = [String]()
    
    private func getEmojiChoices() -> [String]{
        let halloween = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
        return halloween
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1;
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("Chosen card is not in cardButtons")
        }
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.backgroundColor = UIColor.white
                //Button title is looked up in dictionary from card identifier
                button.setTitle(emoji(for: card), for: UIControlState.normal)
            }else{
                button.setTitle("", for: UIControlState.normal)
                //button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.white.withAlphaComponent(0) : UIColor.orange
            }
        }
        
    }
    
    private var emoji = [Int : String]()
    private func emoji(for card: Card) -> String {
        //if card.identifier is not in dictionary and there are still emojis to choose from
        //identifier is inserted into dictionary with random emoji
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: (emojiChoices.count-1).arc4Random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //updateViewFromModel()
        emojiChoices = getEmojiChoices()
        updateViewFromModel()
    }
}

extension Int {
    var arc4Random: Int {
        switch self {
        case 1...Int.max:
            return Int(arc4random_uniform(UInt32(self)))
        case -Int.max...0:
            return -Int(arc4random_uniform(UInt32(abs(self))))
        default:
            return 0
        }
    }
}


