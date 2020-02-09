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
    
    enum ToastType {
        case positive
        case negative
        case generic
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.systemGray4
        doActionForEachButton(self.view, doAction: { (button) in
            button.setBlueBorderWithRadius()
        })
    }
    
    func showToast(message: String, type: ToastType) {
        let toastContainer = UIView(frame: CGRect())
        
        var bgColor = UIColor()
        if type == .positive {
            bgColor = UIColor.green.withAlphaComponent(0.6)
        } else if type == .negative{
            bgColor = UIColor.red.withAlphaComponent(0.6)
        } else if type == .generic {
            bgColor = UIColor.black.withAlphaComponent(0.6)
        }
        
        toastContainer.backgroundColor = bgColor
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 25;
        toastContainer.clipsToBounds  =  true

        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = type == .positive ? UIColor.black : UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0

        toastContainer.addSubview(toastLabel)
        self.view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false

        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])

        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -75)
        self.view.addConstraints([c1, c2, c3])

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
            toastContainer.alpha = 0.0
        }, completion: {_ in
            toastContainer.removeFromSuperview()
            })
        })
   }
    
    func doActionForEachButton(_ view: UIView, doAction action: @escaping (_ button: UIButton) -> Void) {
        for view in view.subviews as [UIView] {
            if let button = view as? UIButton {
                action(button)
            } else {
                doActionForEachButton(view, doAction: action)
            }
        }
    }
    
}
