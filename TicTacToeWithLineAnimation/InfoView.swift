//
//  InfoView.swift
//  TicTacToeWithLineAnimation
//
//  Created by binyu on 2021/7/30.
//

import UIKit

class InfoView: UIView {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        okButton.tintColor = .white
        textLabel.textColor  = .white
        self.backgroundColor = .black
        layer.cornerRadius = 10
        layer.borderWidth = 5
        layer.borderColor = UIColor.gray.cgColor
    }

    func show(text: String) {
        textLabel.text = text
        superview?.bringSubviewToFront(self)
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            self.center = self.superview!.center
        }
        animator.startAnimation()
    }
    
    func close() {
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            self.frame.origin.y = self.superview!.frame.maxY
        }
        
        animator.addCompletion { (_) in
            self.frame.origin.y = -self.frame.height
        }
        
        animator.startAnimation()
    }
    
}
