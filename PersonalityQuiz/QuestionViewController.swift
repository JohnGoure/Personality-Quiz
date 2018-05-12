//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by john goure on 5/11/18.
//  Copyright © 2018 john goure. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var question: [Question] = [
        Question("Which food do you like the most?",
                 .single,
                 [Answer("Steak", .usa),
                  Answer("Fish", .northkorea),
                  Answer("Carrots", .russia),
                  Answer("Sushi", .china)
            ]),
        Question("Which activities do you enjoy?",
                 .multiple,
                 [Answer("Swimming", .northkorea),
                  Answer("Sleeping", .usa),
                  Answer("Cuddling", .russia),
                  Answer("Eating", .china)
            ]),
        Question("How much do you enjoy car rides?",
                 .ranged,
                 [Answer("I dislike them", .china),
                  Answer("I get a little nervous", .russia),
                  Answer("I barely notice them", .northkorea),
                  Answer("I love them", .usa)
            ]),
        Question("Are you the life of the party or more of a netflix and chill type?",
                 .yesNo,
                 [Answer("Life of the party", .usa ),
                  Answer("Netflix and Chill", .russia),
            ])
        ]
    
    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBOutlet weak var yesNoStackView: UIStackView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func yesNoButtonPressed(_ sender: UIButton) {
        let currentAnswers = question[questionIndex].answers
        
        switch sender {
        case yesButton:
            answersChosen.append(currentAnswers[0])
        case noButton:
            answersChosen.append(currentAnswers[1])
        default:
            break
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = question[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = question[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = question[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        yesNoStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex+1)"
        
        let currentQuestion = question[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(question.count)
        
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(currentAnswers)
        case .multiple:
            updateMultipleStack(currentAnswers)
        case .ranged:
            updateRangedStack(currentAnswers)
        case .yesNo:
            updateYesNoStack(currentAnswers)
        }
    }
    
    func updateSingleStack(_ answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(_ answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(_ answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    func updateYesNoStack(_ answers: [Answer]) {
        yesNoStackView.isHidden = false
        yesButton.setTitle(answers[0].text, for: .normal)
        noButton.setTitle(answers[1].text, for: .normal)
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < question.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
