//
//  ViewController.swift
//  Flashcards
//
//  Created by Cierra Ouellette on 2/20/21.
//

import UIKit

// flashcard object
struct Flashcard
{
    var question: String
    var answer: String
    var answerOne: String?
    var answerThree: String?
}

class ViewController: UIViewController
{

    //view did load function
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //answer label behind big flashcard
        answer2Label.clipsToBounds = true
        answer2Label.layer.cornerRadius = 20.0
        
        //big flashcard label
        questionLabel.clipsToBounds = true
        questionLabel.layer.cornerRadius = 20.0

        //multiple choice option one
        optionOne.layer.cornerRadius = 20.0
        optionOne.layer.borderWidth = 3.0
        optionOne.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        //multiple choice option two
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
        if flashcards.count == 0
        {
            updateFlashcard(question: "What's your question?", answer: "Answer", answerOne: "False answer?", answerThree: "False answer?", isExisting: false)
        }
        
        //if there are saved flashcards, update the labels and update the buttons
        else
        {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //animate flashcard to bounce in
        flashcard.alpha = 0.0 //flashcard is invisible
        flashcard.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75) //slightly smaller
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.flashcard.alpha = 1.0
            self.flashcard.transform = CGAffineTransform.identity
        })
        
        //animate option one to bounce in
        optionOne.alpha = 0.0 //option is invisible
        optionOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75) //slightly smaller
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.optionOne.alpha = 1.0
            self.optionOne.transform = CGAffineTransform.identity
        })

        //animate option two to bounce in
        optionTwo.alpha = 0.0 //option is invisible
        optionTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75) //slightly smaller
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.optionTwo.alpha = 1.0
            self.optionTwo.transform = CGAffineTransform.identity
        })
        
        //animate option three to bounce in
        optionThree.alpha = 0.0 //option is invisible
        optionThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75) //slightly smaller
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.optionThree.alpha = 1.0
            self.optionThree.transform = CGAffineTransform.identity
        })
    }
    
//IB outlets
    @IBOutlet weak var flashcard: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer2Label: UILabel!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
//variables
    var flashcards = [Flashcard]() //flashcards array
    var currentIndex = 0 //current index in the flashcards array (user location)
    var didTapOnPrevButton = false //for button animation
    var correctAnswerButton: UIButton! //button to remember what the correct answer is
    
    
//tapped on big flashcard
    @IBAction func didTapOnFlashcard(_ sender: Any)
    {
        flipFlashcard()
    }
    
//tap on prev button, update
    @IBAction func didTapOnPrevButton(_ sender: Any)
    {
        didTapOnPrevButton = true;
        currentIndex = currentIndex - 1
        updateNextPrevButtons()
        animateCardOut()
    }
//tap on next, update
    @IBAction func didTapOnNextButton(_ sender: Any)
    {
        currentIndex = currentIndex + 1
        updateNextPrevButtons()
        animateCardOut()
    }

    @IBAction func didTapOptionOne(_ sender: Any)
    {
        if optionOne == correctAnswerButton
        {
            flipFlashcard()
            optionOne.clipsToBounds = true
            optionOne.layer.cornerRadius = 20.0
            optionOne.layer.borderWidth = 3.0
            optionOne.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else
        {
            optionOne.isEnabled = false
        }
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any)
    {
        if optionTwo == correctAnswerButton
        {
            flipFlashcard()
            optionTwo.clipsToBounds = true
            optionTwo.layer.cornerRadius = 20.0
            optionTwo.layer.borderWidth = 3.0
            optionTwo.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else
        {
            optionTwo.isEnabled = false
        }
    }
    
    @IBAction func didTapOptionThree(_ sender: Any)
    {
        if optionThree == correctAnswerButton
        {
            flipFlashcard()
            optionThree.clipsToBounds = true
            optionThree.layer.cornerRadius = 20.0
            optionThree.layer.borderWidth = 3.0
            optionThree.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else
        {
            optionThree.isEnabled = false
        }
    }
    

//update labels
    func updateLabels()
    {
        let currentFlashcard = flashcards[currentIndex]
        let buttons = [optionOne, optionTwo, optionThree].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.answerOne, currentFlashcard.answerThree].shuffled()
            
        for (button, answer) in zip(buttons, answers)
        {
            button?.setTitle(answer, for: .normal)
            if answer == currentFlashcard.answer
            {
                correctAnswerButton = button
            }
        }
            
        questionLabel.text = currentFlashcard.question
        answer2Label.text = currentFlashcard.answer
        questionLabel.isHidden = false
            
        optionOne.isEnabled = true
        optionTwo.isEnabled = true
        optionThree.isEnabled = true
            
        optionOne.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        optionThree.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        optionTwo.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
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
    
//delete flashcard
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

//animations
    
//flip flashcard animation
    func flipFlashcard(){
        UIView.transition(with: flashcard, duration: 0.3, options: .transitionFlipFromRight) {
            if(self.questionLabel.isHidden){
                self.questionLabel.isHidden = false
            }
            else{
                self.questionLabel.isHidden = true
            }
        }
    }
//card moves to left animation
    func animateCardOut(){
        if(didTapOnPrevButton == false){
        UIView.animate(withDuration: 0.25) {
            self.flashcard.transform = CGAffineTransform.identity.translatedBy(x: -350.0, y: 0.0)
        } completion: { finished in
            self.updateLabels()
            self.animateCardIn()
        }}
        
        else{
        UIView.animate(withDuration: 0.25) {
            self.flashcard.transform = CGAffineTransform.identity.translatedBy(x: 350.0, y: 0.0)
        } completion: { finished in
            self.updateLabels()
            self.animateCardIn()
        }}
        }
    
//new card comes in from right animation
    func animateCardIn(){
        if(didTapOnPrevButton == false){
        flashcard.transform = CGAffineTransform.identity.translatedBy(x: 350.0, y: 0.0)
        UIView.animate(withDuration: 0.25) {
            self.flashcard.transform = CGAffineTransform.identity
        }}
        else{
            flashcard.transform = CGAffineTransform.identity.translatedBy(x: -350.0, y: 0.0)
            UIView.animate(withDuration: 0.25) {
                self.flashcard.transform = CGAffineTransform.identity
            }
        }
        didTapOnPrevButton = false
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

//enable/disable next/prev
    func updateNextPrevButtons(){
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

