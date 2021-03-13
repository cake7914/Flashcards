//
//  ViewController.swift
//  Flashcards
//
//  Created by Cierra Ouellette on 2/20/21.
//

import UIKit

// flashcard object
struct Flashcard {
    var question: String
    var answer: String
    var answerOne: String?
    var answerThree: String?
}

class ViewController: UIViewController {

    //view did load function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //answer label behind multiple choice answer
        answerLabel.clipsToBounds = true
        answerLabel.layer.cornerRadius = 20.0
        answerLabel.layer.cornerRadius = 20.0
        answerLabel.layer.borderWidth = 3.0
        answerLabel.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        //answer label behind big q
        answer2Label.clipsToBounds = true
        answer2Label.layer.cornerRadius = 20.0
        
        //big q label
        questionLabel.clipsToBounds = true
        questionLabel.layer.cornerRadius = 20.0

        //multiple choice option one
        optionOne.layer.cornerRadius = 20.0
        optionOne.layer.borderWidth = 3.0
        optionOne.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        //multiple choice option two (answer)
        optionTwo.layer.cornerRadius = 20.0
        optionTwo.layer.borderWidth = 3.0
        optionTwo.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        //multiple choice option three
        optionThree.layer.cornerRadius = 20.0
        optionThree.layer.borderWidth = 3.0
        optionThree.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)

        //flashcard view
        flashcard.layer.cornerRadius = 20.0
        flashcard.layer.shadowRadius = 20.0
        flashcard.layer.shadowOpacity = 0.4
        
        //read any saved flashcards
        readSavedFlashcards()
        //if there are no saved flashcards, put in basic q&a
        if flashcards.count == 0 {
            updateFlashcard(question: "What's your question?", answer: "Answer", answerOne: "False answer?", answerThree: "False answer?", isExisting: false)
        }
        //if there are, update the labels and update the buttons
        else{
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBOutlet weak var flashcard: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer2Label: UILabel!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards = [Flashcard]() //flashcards array
    var currentIndex = 0 //current index in the flashcards array (user location)
    
    //tap on prev button, update
    @IBAction func didTapOnPrevButton(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    //tap on next, update
    @IBAction func didTapOnNextButton(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
    }
    //tap on delete, confirm? delete
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        //add actions to alert
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in self.deleteCurrentFlashcard()})
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        //present alert
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        if currentIndex == -1
        {
            updateFlashcard(question: "What's your question?", answer: "Answer", answerOne: "False answer?", answerThree: "False answer?", isExisting: false)
            currentIndex = 0
        }
        
        updateLabels()
        updateNextPrevButtons()
        saveAllFlashcardsToDisk()  
    }
    //update labels
    func updateLabels(){
        
        let currentFlashcard = flashcards[currentIndex]
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer
        answer2Label.text = currentFlashcard.answer
        
        optionOne.setTitle(currentFlashcard.answerOne, for: .normal)
        optionTwo.setTitle(currentFlashcard.answer, for: .normal)
        optionThree.setTitle(currentFlashcard.answerThree, for: .normal)
        
        optionOne.isHidden = false
        optionTwo.isHidden = false
        optionThree.isHidden = false
        answerLabel.isHidden = true
    }
    //tapped on big flashcard
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(questionLabel.isHidden){
            questionLabel.isHidden = false
        }
        else{
            questionLabel.isHidden = true
        }
    }
    //update the flashcard
    func updateFlashcard(question: String, answer: String, answerOne: String?, answerThree: String?, isExisting: Bool) {
        
        let flashcard = Flashcard(question: question, answer: answer, answerOne: answerOne, answerThree: answerThree) // create new flashcards object
        
        if isExisting{
            flashcards[currentIndex] = flashcard
        }
        else{
        flashcards.append(flashcard) //add to array
        currentIndex = flashcards.count - 1 //new index
        }
        updateLabels() //update labels
        print("Added new flashcard! We now have \(flashcards.count) flashcards.")
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons() //update buttons
        saveAllFlashcardsToDisk() //save info!
    }
    
    func updateNextPrevButtons(){ //enable/disable next/prev
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }
        else{
            prevButton.isEnabled = true
        }
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
    
    //segue between screens
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        if segue.identifier == "EditSegue" {
        creationController.initialQuestion = questionLabel.text
        creationController.initialAnswer = answer2Label.text
        creationController.initialAnswerOne =         optionOne.currentTitle
        creationController.initialAnswerThree = optionThree.currentTitle
        }
    }
    
    //save information
    func saveAllFlashcardsToDisk()
    {
        let dictionaryArray = flashcards.map { (card) -> [String: String?] in return ["question": card.question, "answer": card.answer, "answerOne": card.answerOne, "answerThree": card.answerThree]}
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults.")
    }
    
    //read saved information
    func readSavedFlashcards()
    {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, answerOne: dictionary["answerOne"], answerThree: dictionary["answerThree"])}
        
                flashcards.append(contentsOf: savedCards)
        }
    }
}

