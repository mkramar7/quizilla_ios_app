//
//  QuestionViewController.swift
//  Quizilla
//
//  Created by Marko Kramar on 08/02/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import UIKit

class QuestionViewController: QuizillaViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    var randomQuestionUrl : String = "http://markokramar.com/quizilla/api/questions/random"
    var currentQuestion: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNextQuestion()
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if sender.tag == self.currentQuestion!.correctAnswerId {
            showAlert(title: "Correct!", message: "Congratulations! The answer is correct!", correct: true)
        } else {
            showAlert(title: "Wrong!", message: "The answer is wrong! Please try again!", correct: false)
        }
    }
    
    func showAlert(title: String, message: String, correct: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            if correct {
                self.getNextQuestion()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func mapQuestionToView() {
        self.questionLabel.text = self.currentQuestion!.question
        for answer in self.currentQuestion!.answers {
            let btn = self.view.viewWithTag(answer.id) as? UIButton
            btn!.setTitle(answer.answer, for: [])
        }
    }
    
    
    func getNextQuestion() {
        var request = URLRequest(url: URL(string: randomQuestionUrl)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            let question = try! JSONDecoder().decode(Question.self, from: data!)
            
            // Prevents consecutive random questions
            if question.id == self.currentQuestion?.id {
                self.getNextQuestion()
                return
            }
            
            DispatchQueue.main.async {
                self.currentQuestion = question
                self.mapQuestionToView()
            }
        }).resume()
    }

}
