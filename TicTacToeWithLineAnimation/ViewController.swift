//
//  ViewController.swift
//  TicTacToeWithLineAnimation
//
//  Created by binyu on 2021/7/30.
//

import UIKit

class ViewController: UIViewController {
    
   
    @IBOutlet var squares: [UIView]!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var oLabel: UILabel!
    @IBOutlet weak var infoView: InfoView!
    
    @IBOutlet var gestureRecognizer: UIPanGestureRecognizer!
    
    let grid: Grid = Grid()
    
    var occupyPieces = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taketurn(label: oLabel)
    }
    
    func taketurn(label: UILabel) {
        
        let rotateAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeIn){
            label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
            
            label.alpha = 0.75
            
        }
        
        let backAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeIn) {
            label.transform = CGAffineTransform.identity
            label.alpha = 1
        }
        
        backAnimator.addCompletion { _ in
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(self.gestureRecognizer)
            self.view.bringSubviewToFront(label)
        }
        
        rotateAnimator.addCompletion { _ in
            backAnimator.startAnimation()
        }
        rotateAnimator.startAnimation()
    }
    
    func newGame() {
        grid.clear()
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 1, options: []) {
            self.occupyPieces.forEach { piece in
                piece.alpha = 0
            }
        } completion: { (_) in
            self.occupyPieces.forEach { piece in
                piece.removeFromSuperview()
            }
            
            self.occupyPieces.removeAll()
            self.taketurn(label: self.oLabel)
            
        }

    }

    @IBAction func infoButtonTapped(_ sender: Any) {
        infoView.show(text: "玩法：將三個相同符號連成一直線的人獲勝")
    }
    
    @IBAction func closeInfoView(_ sender: Any) {
        infoView.close()
        
        if grid.winner != nil || grid.isTie {
            newGame()
        }
    }
    
    
    func pieceBackToStartLocation(label: UILabel) {
        UIView.animate(withDuration: 0.5) {
            label.transform = .identity
        }
    }
    
    func creatPieceLabel(label: UILabel) -> UILabel {
        let newLabel = UILabel(frame: label.frame)
        newLabel.text = label.text
        newLabel.font = label.font
        newLabel.textColor = label.textColor
        newLabel.textAlignment = label.textAlignment
        newLabel.alpha = 0.5
        newLabel.isUserInteractionEnabled = false
        return newLabel
    }
    
    func finishCurrentTurn(label: UILabel,index: Int, originalPieceCenter: CGPoint ) {
        
        occupyPieces.append(label)
        let newLabel = creatPieceLabel(label: label)
        newLabel.center = originalPieceCenter
        view.addSubview(newLabel)
        
        let nextLabel: UILabel
        
        if label == xLabel {
            self.grid.occupy(piece: .X, on: index)
            xLabel = newLabel
            nextLabel = oLabel
        } else {
            self.grid.occupy(piece: .O, on: index)
            oLabel = newLabel
            nextLabel = xLabel
        }
        
        if let winner = grid.winner {
            if winner == Grid.Piece.O{
                infoView.show(text: "O Win")
            }else {
                infoView.show(text: "X Win")
            }
        }else if grid.isTie {
            infoView.show(text: "Tie")
        } else {
            taketurn(label: nextLabel)
        }
        
    }
    
    func placePiece(_ label: UILabel, on square: UIView, index: Int) {
        
        var originalPieceCenter = CGPoint.zero
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: []) {
            label.transform = .identity
            originalPieceCenter = label.center
            label.center = square.center
        } completion: { _ in
            self.finishCurrentTurn(label: label, index: index, originalPieceCenter: originalPieceCenter)
        }
    }
    
    @IBAction func movePiece(_ sender: UIPanGestureRecognizer) {
        
        guard let label = sender.view as? UILabel else { return }
        
     
        if sender.state == .ended {
            
            var maxIntersectionrea: CGFloat = 0
            var targetSquare: UIView?
            var targetIndex: Int?
            
            
            
            for (i, square) in squares.enumerated() {
                let intersectionFrame = square.frame.intersection(label.frame)
                let area = intersectionFrame.width * intersectionFrame.height
                
                if area > maxIntersectionrea {
                    if (grid.isSquareEmpty(index: i)) {
                        maxIntersectionrea = area
                        targetSquare = square
                        targetIndex = i
                    }
                }
            }
            
            if let targetSquare = targetSquare, let targetIndex = targetIndex {
               
                placePiece(label, on: targetSquare, index: targetIndex)
                
            } else {
                pieceBackToStartLocation(label: label)
            }
            
        }else {
            let translation = sender.translation(in: label)
            
            label.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        }
    }
    
    
}

