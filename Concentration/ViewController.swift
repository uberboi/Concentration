//
//  ViewController.swift
//  Concentration
//
//  Created by Steven Huang on 9/1/18.
//  Copyright © 2018 Steven Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var emojiChoices = ["🎃", "👻", "🎃", "👻"]
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1;
        if let cardNumber = cardButtons.index(of: sender){
            flipcard(withEmoji: emojiChoices[cardNumber], on: sender)
        }else{
            print("Chosen card is not in cardButtons")
        }
    }
    
    func flipcard(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji{
            button.backgroundColor = UIColor.orange
            button.setTitle("", for: UIControlState.normal)
        }else{
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = UIColor.white
        }
    }
}


