//
//  QuizillaViewController.swift
//  Quizilla
//
//  Created by Marko Kramar on 09/02/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation
import UIKit

class QuizillaViewController: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.systemGray4
        setBlueBorderWithRadiusForAllButtons(self.view)
    }
    
    private func setBlueBorderWithRadiusForAllButtons(_ view: UIView){
        for view in view.subviews as [UIView] {
            if let button = view as? UIButton {
                button.setBlueBorderWithRadius()
            } else {
                setBlueBorderWithRadiusForAllButtons(view)
            }
        }
    }
    
}
