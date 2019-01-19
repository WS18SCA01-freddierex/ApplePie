//
//  ViewController.swift
//  ApplePie
//
//  Created by freddieRex on 1/16/19.
//  Copyright © 2019 Fredrex Enterprises. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
   
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var listOfWords: [String] = ["mets","jets","giants","yankess","Bills","islanders","knicks","nets"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        }else{
            updateUI()
        }
        
    
    }

   
    func newRound(){
        
        if !listOfWords.isEmpty{
            
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining:
                incorrectMovesAllowed, guessedLetters: [])
            updateUI()
            enableLetterButtons(true)
        }else{
            enableLetterButtons(false)
            
        }
        
    }
    
    private func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters{
            letters.append(String(letter))
        }
        let wordwithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordwithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        }
        
}

