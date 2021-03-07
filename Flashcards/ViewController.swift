//
//  ViewController.swift
//  Flashcards
//
//  Created by Cierra Ouellette on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerLabel.clipsToBounds = true
        answerLabel.layer.cornerRadius = 20.0
        answerLabel.layer.cornerRadius = 20.0
        answerLabel.layer.borderWidth = 3.0
        answerLabel.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        answer2Label.clipsToBounds = true
        answer2Label.layer.cornerRadius = 20.0
        
        questionLabel.clipsToBounds = true
        questionLabel.layer.cornerRadius = 20.0

        optionOne.layer.cornerRadius = 20.0
        optionOne.layer.borderWidth = 3.0
        optionOne.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        optionTwo.layer.cornerRadius = 20.0
        optionTwo.layer.borderWidth = 3.0
        optionTwo.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)

        optionThree.layer.cornerRadius = 20.0
        optionThree.layer.borderWidth = 3.0
        optionThree.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)

        flashcard.layer.cornerRadius = 20.0
        flashcard.layer.shadowRadius = 20.0
        flashcard.layer.shadowOpacity = 0.4
        
        
    }

    @IBOutlet weak var flashcard: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer2Label: UILabel!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(questionLabel.isHidden){
            questionLabel.isHidden = false
        }
        else{
            questionLabel.isHidden = true
        }
    }
    
    func updateFlashcard(question: String, answer: String, answerOne: String?, answerThree: String?) {
        questionLabel.text = question
        answer2Label.text = answer
        answerLabel.text = answer
        
        optionOne.setTitle(answerOne, for: .normal)
        optionTwo.setTitle(answer, for: .normal)
        optionThree.setTitle(answerThree, for: .normal)
        
        optionOne.isHidden = false
        optionTwo.isHidden = false
        optionThree.isHidden = false
        answerLabel.isHidden = true
        
    }

    
    @IBAction func didTapOptionOne(_ sender: Any) {
        optionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        optionTwo.isHidden = true
        answerLabel.isHidden = false
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        optionThree.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        if segue.identifier == "EditSegue" {
        creationController.initialQuestion = questionLabel.text
        creationController.initialAnswer = answer2Label.text
        }
    }
    
}

