//
//  ViewController.swift
//  AppleTree
//
//  Created by Wolfpack Digital on 23.07.2021.
//

import UIKit

var listOfWords = ["buccaneer", "swift", "glorious",
"incandescent", "bug", "program", "cat"]
let incorrectMovesAllowed = 7
var totalWins = 0
var totalLosses = 0
var currentGame: Game!

class ViewController: UIViewController
{

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()

    }

    func newRound()
    {
        if !listOfWords.isEmpty
        {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord,
            incorrectMovesRemaining: incorrectMovesAllowed,
            guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else
        {
            enableLetterButtons(false)
        }
    }
    
    
    func enableLetterButtons(_ enable: Bool)
    {
      for button in letterButtons
      {
        button.isEnabled = enable
      }
    }
    
    func updateUI()
    {
        var letters = [String]()
        for letter in currentGame.formattedWord
        {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    @IBAction func letterButtonPressed(_ sender: UIButton)
    {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
            updateGameState()
    }
    
    func updateGameState()
    {
      if currentGame.incorrectMovesRemaining == 0
      {
        totalLosses += 1
      } else if currentGame.word == currentGame.formattedWord
      {
        totalWins += 1
      } else
      {
         updateUI()
      }
    }
    
    var totalWins = 0
    {
        didSet
        {
            newRound()
        }
    }
    var totalLosses = 0
    {
        didSet
        {
            newRound()
        }
    }
}

