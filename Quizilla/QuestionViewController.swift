//
//  QuestionViewController.swift
//  Quizilla
//
//  Created by Marko Kramar on 08/02/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    @IBOutlet weak var btnAnswer4: UIButton!
    
    var randomQuestionUrl : String = "http://markokramar.com/quizilla/api/questions/random"
    var correctAnswerId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNextQuestion()
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if Int(sender.tag) == correctAnswerId {
            showAlert(title: "Correct!", message: "Congratulations! The answer is correct!", correct: true)
        } else {
            showAlert(title: "Wrong!", message: "The answer is wrong!", correct: false)
        }
    }
    
    func showAlert(title: String, message: String, correct: Bool) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            if correct {
                self.getNextQuestion()
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    
    func getNextQuestion() {
        questionLabel.text = "Loading next question..."
        btnAnswer1.setTitle("Loading answer...", for: UIControl.State.normal)
        btnAnswer2.setTitle("Loading answer...", for: UIControl.State.normal)
        btnAnswer3.setTitle("Loading answer...", for: UIControl.State.normal)
        btnAnswer4.setTitle("Loading answer...", for: UIControl.State.normal)
        
        var request = URLRequest(url: URL(string: randomQuestionUrl)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let rawJson = try JSONSerialization.jsonObject(with: data!)
                if let dictionary = rawJson as? [String: Any] {
                    if let question = dictionary["question"] as? String {
                        DispatchQueue.main.async {
                            self.questionLabel.text = question
                        }
                    }
                    
                    if let answers = dictionary["answers"] as? [Any] {
                        for answerObj in answers {
                            if let answer = answerObj as? [String: Any] {
                                if let id = answer["id"] as? Int, let answerString = answer["answer"] as? String {
                                    DispatchQueue.main.async {
                                        if (id == 1) {
                                            self.btnAnswer1.setTitle(answerString, for: UIControl.State.normal)
                                        } else if (id == 2) {
                                           self.btnAnswer2.setTitle(answerString, for: UIControl.State.normal)
                                        } else if (id == 3) {
                                            self.btnAnswer3.setTitle(answerString, for: UIControl.State.normal)
                                        } else if (id == 4) {
                                            self.btnAnswer4.setTitle(answerString, for: UIControl.State.normal)
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    
                    if let correctAnswer = dictionary["correctAnswerId"] as? Int {
                        self.correctAnswerId = correctAnswer
                    }
                }
            } catch {
                print("error")
            }
        })

        task.resume()
    }

}
