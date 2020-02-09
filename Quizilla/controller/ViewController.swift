//
//  ViewController.swift
//  Quizilla
//
//  Created by Marko Kramar on 21/12/2019.
//  Copyright © 2019 Marko Kramar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in buttons {
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questionSegue" {
            let questionViewController = segue.destination as! QuestionViewController
            questionViewController.title = "Question"
        }
    }
    
    @IBAction func newGame(_ sender: Any) {
        performSegue(withIdentifier: "questionSegue", sender: nil)
    }
    
}

