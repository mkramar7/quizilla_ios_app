//
//  ButtonUtil.swift
//  Quizilla
//
//  Created by Marko Kramar on 09/02/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setBlueBorderWithRadius() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.clipsToBounds = true
    }
    
}
