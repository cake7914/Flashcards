//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Cierra Ouellette on 3/6/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var answerOneTextField: UITextField!
    @IBOutlet weak var answerThreeTextField: UITextField!
    
    var flashcardsController: ViewController!
    var initialQuestion: String?
    var initialAnswer: String?
    var initialAnswerOne: String?
    var initialAnswerThree: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        answerOneTextField.text = initialAnswerOne
        answerThreeTextField.text = initialAnswerThree
    }
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let answerOneText = answerOneTextField.text
        let answerThreeText = answerThreeTextField.text
        
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty)
        {
            let alert = UIAlertController(title: "Missing Text", message: "Please enter in an answer and question", preferredStyle: UIAlertController.Style.alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        }
        else
        {
            var isExisting = false
            if initialQuestion != nil{
                isExisting = true
            }
            
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, answerOne: answerOneText!, answerThree: answerThreeText!, isExisting: isExisting)
        
        dismiss(animated: true)
        }
    }
    
}
