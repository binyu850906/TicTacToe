//
//  GridView.swift
//  TicTacToeWithLineAnimation
//
//  Created by binyu on 2021/7/30.
//

import UIKit

class GridView: UIView {
   
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let squareWidth: CGFloat = 110.0
        let lineWidth: CGFloat = 15.0
        
        var y = squareWidth + (lineWidth / 2)
        
        path.move(to: CGPoint(x: 0, y: y))
        path.addLine(to: CGPoint(x: rect.width, y: y))
        
        y += squareWidth + lineWidth
        path.move(to: CGPoint(x: 0, y: y))
        path.addLine(to: CGPoint(x: rect.width, y: y))
        
        var x = squareWidth + (lineWidth / 2)
        
        path.move(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x, y: rect.height))
        
        x += squareWidth + lineWidth
        path.move(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x, y: rect.height))
        
        
        path.lineWidth = lineWidth
        
        UIColor.gray.setStroke()
        path.stroke()
        path.close()
    }
    

}
