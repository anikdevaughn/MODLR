//
//  MODLR-UIView.swift
//  MODLR-TEST
//
//  Created by Chris Slowik on 1/11/16.
//  Copyright © 2016 Creativedash. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyYellowGradient() {
        applyGradientBG(UIColor.lightYellow(), color2: UIColor.medYellow())
    }
    
    func applyGradientBG(color1: UIColor, color2: UIColor) {
        // make sure the view has accounted for constraints etc
        layoutIfNeeded()
        
        // create the gradient layer and set it to the same size as the view
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        // set up the gradient colors
        gradientLayer.colors = [color1.CGColor, color2.CGColor]
        
        // gradient locations and start/end points
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.35, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.65, y: 1)
        
        self.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
}